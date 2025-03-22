Coffee.Modulate = {
    Resolution = Coffee.Resolution,
    Materials = Coffee.Materials,
    Client = Coffee.Client,
    Config = Coffee.Config,
    Colors = Coffee.Colors,

    World = game.GetWorld( )
}

function Coffee.Modulate:UpdateWorld( Enabled, Color )
    if ( not self.World ) then 
        return
    end

    if ( not Enabled ) then 
        Color = self.Colors.White
    end

    local Materials = self.World:GetMaterials( )

    for i = 1, #Materials do 
        local Texture = Material( Materials[ i ] )

        if ( not Texture or Texture:IsError( ) ) then 
            continue 
        end 
        
        Texture:SetVector( '$color', Vector( Color.r / 255, Color.g / 255, Color.b / 255 ) )
        Texture:SetFloat( '$alpha', Color.a / 255 )
    end
end

function Coffee.Modulate:UpdateEffects( )
    if ( self.Config[ 'world_color_overlay' ] ) then 
        local Modification = {
            [ '$pp_colour_addr' ] = 0,
            [ '$pp_colour_addg' ] = 0,
            [ '$pp_colour_addb' ] = 0,

            [ '$pp_colour_mulr' ] = 0,
            [ '$pp_colour_mulg' ] = 0,
            [ '$pp_colour_mulb' ] = 0,
            
            [ '$pp_colour_brightness' ] = self.Config[ 'world_color_overlay_brightness' ] / 255,
            [ '$pp_colour_contrast' ]   = self.Config[ 'world_color_overlay_contrast' ],
            [ '$pp_colour_colour' ]     = self.Config[ 'world_color_overlay_saturation' ],
            
            [ '$pp_colour_inv' ]        = self.Config[ 'world_color_overlay_invert' ] and 1 or 0,
        }

        if ( self.Config[ 'world_color_overlay_multiply' ] ) then 
            local Color = self.Config[ 'world_color_overlay_multiply_color' ]

            Modification[ '$pp_colour_mulr' ] = Color.r
            Modification[ '$pp_colour_mulg' ] = Color.g
            Modification[ '$pp_colour_mulb' ] = Color.b
        end

        if ( self.Config[ 'world_color_overlay_add' ] ) then 
            local Color = self.Config[ 'world_color_overlay_add_color' ]

            Modification[ '$pp_colour_addr' ] = Color.r / 255
            Modification[ '$pp_colour_addg' ] = Color.g / 255
            Modification[ '$pp_colour_addb' ] = Color.b / 255
        end

        DrawColorModify( Modification )
    end

    if ( self.Config[ 'world_material_overlay' ] ) then 
        DrawMaterialOverlay( 
            self.Config[ 'world_material_overlay_material' ], 
            self.Config[ 'world_material_overlay_refract' ] 
        )
    end

    if ( self.Config[ 'world_bloom' ] ) then 
        local Color = self.Config[ 'world_bloom_color' ]

        DrawBloom( 
            self.Config[ 'world_bloom_light' ], 
            self.Config[ 'world_bloom_multiply' ], 
            self.Config[ 'world_bloom_size_x' ], 
            self.Config[ 'world_bloom_size_y' ], 
            self.Config[ 'world_bloom_passes' ], 
            self.Config[ 'world_bloom_vivid' ], 
            Color.r / 255, 
            Color.g / 255, 
            Color.b / 255 
        )
    end

    if ( self.Config[ 'world_motion_blur' ] ) then 
        DrawMotionBlur( 
            self.Config[ 'world_motion_blur_alpha' ], 
            self.Config[ 'world_motion_blur_alpha_frames' ], 
            self.Config[ 'world_motion_blur_delay' ]
        )
    end

    if ( self.Config[ 'world_sharpen' ] ) then 
        local Contrast = self.Config[ 'world_sharpen_contrast' ]

        if ( self.Config[ 'world_sharpen_exponent' ] ) then 
            -- This is mostly here to just play around with.
            Contrast = Contrast ^ 2
        end
        
        DrawSharpen( 
            Contrast, 
            self.Config[ 'world_sharpen_distance' ] 
        )
    end

    if ( self.Config[ 'world_sobel' ] ) then 
        DrawSobel( 
            self.Config[ 'world_sobel_threshold' ] 
        ) 
    end

    if ( self.Config[ 'world_sunbeams' ] ) then 
        -- https://github.com/Facepunch/garrysmod/blob/7324e6e6b2ea1671750bd101043ba05d0ddc2c7e/garrysmod/lua/postprocess/sunbeams.lua#L31
        local Info = util.GetSunInfo( )

        if ( Info and Info.obstruction != 0 ) then
            local Adjusted = ( self.Client.EyePos + Info.direction * 4096 ):ToScreen( )
        
            if ( ( Info.direction:Dot( EyeVector( ) ) - 0.8 ) * 5 > 0 ) then 
                DrawSunbeams( 
                    self.Config[ 'world_sunbeams_multiply' ], 
                    self.Config[ 'world_sunbeams_darkness' ],
                    self.Config[ 'world_sunbeams_size' ],
                    Adjusted.x / self.Resolution.Width,
                    Adjusted.y / self.Resolution.Height
                )
            end
        end
    end

    if ( self.Config[ 'world_texturized' ] ) then 
        DrawTexturize( 
            self.Config[ 'world_texturized_scale_random' ] and math.random( ) or self.Config[ 'world_texturized_scale' ],
            Material( self.Config[ 'world_texturized_material' ] )
        )
    end
end

function Coffee.Modulate:UpdateWorldMaterial( )
   if ( self.Config[ 'world_material' ] ) then 
        render.WorldMaterialOverride( 
            Material( self.Config[ 'world_material_material' ] )
        ) 
   end

    if ( self.Config[ 'world_fullbright' ] ) then 
        render.SetLightingMode( self.Config[ 'world_fullbright_mode' ] == 'Total' and 1 or 2 )
    end
end

function Coffee.Modulate:PostUpdateWorldMaterial( )
    if ( self.Config[ 'world_fullbright' ] ) then 
        render.SetLightingMode( 0 )
    end
end

function Coffee.Modulate:SetupWorldFog( )
    if ( not self.Config[ 'world_fog' ] ) then 
        return
    end

    local Color = self.Config[ 'world_fog_color' ]

    render.FogMode( MATERIAL_FOG_LINEAR )
    render.FogStart( self.Config[ 'world_fog_start' ] )
    render.FogEnd( self.Config[ 'world_fog_end' ] )
    render.FogMaxDensity( Color.a / 255 )
    render.FogColor( Color.r, Color.g, Color.b )

    return true
end

function Coffee.Modulate:SetupSkyboxFog( Scale )
    if ( not self.Config[ 'world_fog' ] ) then 
        return
    end

    local Color = self.Config[ 'world_fog_color' ]

    render.FogMode( MATERIAL_FOG_LINEAR )
    render.FogStart( self.Config[ 'world_fog_start' ] * Scale )
    render.FogEnd( self.Config[ 'world_fog_end' ] * Scale )
    render.FogMaxDensity( Color.a / 255 )
    render.FogColor( Color.r, Color.g, Color.b )

    return true
end

Coffee.Hooks:New( 'SetupSkyboxFog', Coffee.Modulate.SetupSkyboxFog, Coffee.Modulate )
Coffee.Hooks:New( 'SetupWorldFog', Coffee.Modulate.SetupWorldFog, Coffee.Modulate )
Coffee.Hooks:New( 'PreDrawEffects', Coffee.Modulate.PostUpdateWorldMaterial, Coffee.Modulate )
Coffee.Hooks:New( 'RenderScene', Coffee.Modulate.UpdateWorldMaterial, Coffee.Modulate )
Coffee.Hooks:New( 'RenderScreenspaceEffects', Coffee.Modulate.UpdateEffects, Coffee.Modulate )