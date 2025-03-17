local Copy		= Material( 'pp/copy' )
local Add		= Material( 'pp/add' )
local Sub		= Material( 'pp/sub' )
local Store		= render.GetScreenEffectTexture( 0 )
local Blur		= render.GetScreenEffectTexture( 1 )
local NoiseMaterial = Material( 'effects/tvnoise' )

function Coffee.Visuals:Halo( Targets, Color, blurX, blurY, scaledBlur, Passes, Bloom, IgnoreZ, innerIllumination, Material, materialColor )
    -- Majority of this was ported from the offical Garry's Mod version of halo.Add. I adjusted things to allow myself
    -- to render stuff without it dripping into the next halo (physgun for example).

    -- https://github.com/Facepunch/garrysmod/blob/38ef74af3f61c177251bd3159f11c27bd0451809/garrysmod/lua/includes/modules/halo.lua#L38

    local Scene = render.GetRenderTarget( )

	-- Store a copy of the original scene.
	render.CopyRenderTargetToTexture( Store )

	-- Clear our scene so that additive/subtractive rendering with it will work later.
	if ( Bloom ) then
		render.Clear( 0, 0, 0, 255, false, true )
	else
		render.Clear( 255, 255, 255, 255, false, true )
	end

	-- For certain materials this is necessary to not have the entire screen go pitch black.
	render.UpdateRefractTexture( )

    -- Either update materials or fix them.
    if ( Material ) then 
        render.MaterialOverride( Material )
        render.SetColorModulation( materialColor.r / 255, materialColor.g / 255, materialColor.b / 255 )
        render.SetBlend( materialColor.a / 255 )
    else
        render.MaterialOverride( nil )
        render.SetColorModulation( 1, 1, 1 )
        render.SetBlend( 1 )
    end

	-- Render colored props to the scene and set their pixels high.
	cam.Start3D( )
		render.SetStencilEnable( true )
			render.SuppressEngineLighting( true )
			cam.IgnoreZ( IgnoreZ )

				render.SetStencilWriteMask( 1 )
				render.SetStencilTestMask( 1 )
				render.SetStencilReferenceValue( 1 )

				render.SetStencilCompareFunction( STENCIL_ALWAYS )
				render.SetStencilPassOperation( STENCIL_REPLACE )
				render.SetStencilFailOperation( innerIllumination and STENCIL_INVERT or STENCIL_KEEP )
				render.SetStencilZFailOperation( STENCIL_KEEP )

					for k, Target in ipairs( Targets ) do
                        if ( IsValid( Target ) ) then 
						    Target:DrawModel( )
                        end
					end

				render.SetStencilCompareFunction( STENCIL_EQUAL )
				render.SetStencilPassOperation( STENCIL_KEEP )
                
					cam.Start2D( )
                        surface.SetDrawColor( Color.r, Color.g, Color.b, Color.a )
						surface.DrawRect( 0, 0, self.Resolution.Width, self.Resolution.Height )
                                            
                        if ( not innerIllumination and Material ) then                    
                            surface.SetDrawColor( materialColor.r, materialColor.g, materialColor.b, materialColor.a )
                            surface.SetMaterial( Material )
                            surface.DrawTexturedRect( 0, 0, self.Resolution.Width, self.Resolution.Height, 0, 0 )
                        end
                    cam.End2D( )

			cam.IgnoreZ( false )
			render.SuppressEngineLighting( false )
		render.SetStencilEnable( false )
	cam.End3D( )

	-- Store a blurred version of the colored props in an RT.
	render.CopyRenderTargetToTexture( Blur )
	render.BlurRenderTarget( Blur, blurX, blurY, scaledBlur and Passes or 1 )

	-- Restore the original scene.
	render.SetRenderTarget( Scene )
	Copy:SetTexture( '$basetexture', Store )
	Copy:SetString( '$color', '1 1 1' )
	Copy:SetString( '$alpha', '1' )
	render.SetMaterial( Copy )
	render.DrawScreenQuad( )

	-- Draw back our blured colored props additively/subtractively, ignoring the high bits.
	render.SetStencilEnable( true )

		render.SetStencilCompareFunction( STENCIL_NOTEQUAL )

		if ( Bloom ) then
			Add:SetTexture( '$basetexture', Blur )
			render.SetMaterial( Add )
		else
			Sub:SetTexture( '$basetexture', Blur )
			render.SetMaterial( Sub )
		end

		for i = 0, Passes do
			render.DrawScreenQuad( )
		end

	render.SetStencilEnable( false )

	-- Return original values.
	render.SetStencilTestMask( 0 )
	render.SetStencilWriteMask( 0 )
	render.SetStencilReferenceValue( 0 )
end

function Coffee.Visuals:Glow( )
    for k, Target in pairs( self.Records.Players ) do 
        if ( not self.Config[ 'esp_enabled' ] or not self.Menu:Keydown( 'esp_enabled_keybind' ) ) then 
            break
        end

        if ( not self.Config[ 'esp_glow' ] ) then 
            break
        end

        if ( not Target:Alive( ) or not self:Valid( Target ) ) then 
            continue
        end

        -- Get front record.
        local Front = self.Config[ 'esp_server' ] and self.Records:GetFront( Target ) or self.Records:Construct( Target, true )

        if ( not Front ) then 
            continue
        end

        -- Get the targets.
        local Targets = {
            Target
        }

        if ( self.Config[ 'esp_glow_weapon' ] ) then 
            table.insert( Targets, Front.Weapon )
        end

        -- See if we need to add rim blur.
        local blurX, blurY, scaledBlur = 1, 1, false

        if ( self.Config[ 'esp_glow_rim' ] ) then 
            blurX      = self.Config[ 'esp_glow_rim_x_suppress' ] and 0 or self.Config[ 'esp_glow_rim_x' ]
            blurY      = self.Config[ 'esp_glow_rim_y_suppress' ] and 0 or self.Config[ 'esp_glow_rim_y' ]
            scaledBlur = self.Config[ 'esp_glow_rim_scaled' ]
        end

        if ( self.Config[ 'esp_glow_pulsate' ] ) then 
            local Scale = math.sin( CurTime( ) * ( self.Config[ 'esp_glow_pulsate_scale' ] / 50 ) )

            blurX = blurX + Scale
            blurY = blurY + Scale
        end

        -- See if we need to add a material.
        local Material

        if ( self.Config[ 'esp_glow_material_overlay' ] ) then 
            Material = self.Materials:Get( self.Config[ 'esp_glow_material_overlay_material' ], false )
        end

        -- Add halo information to the render buffer.
        if ( self.Config[ 'esp_glow_overlay' ] ) then 
            self:Halo( 
                Targets, 
                self.Config[ 'esp_glow_overlay_color' ], 
                blurX / 2, 
                blurY / 2, 
                scaledBlur,
                self.Config[ 'esp_glow_passes' ], 
                not self.Config[ 'esp_glow_overlay_bloom' ], 
                true,
                self.Config[ 'esp_glow_overlay_self_illumination' ]
            )
        end

        self:Halo( 
            Targets, 
            self.Config[ 'esp_glow_color' ], 
            blurX, 
            blurY, 
            scaledBlur,
            self.Config[ 'esp_glow_passes' ], 
            not self.Config[ 'esp_glow_bloom' ], 
            true,
            self.Config[ 'esp_glow_self_illumination' ],
            Material,
            self.Config[ 'esp_glow_material_overlay_color' ]
        )
    end
end

Coffee.Hooks:New( 'PreDrawHalos', Coffee.Visuals.Glow, Coffee.Visuals )