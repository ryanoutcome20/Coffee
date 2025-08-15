function Coffee.Visuals:Valid( Target )
    if ( not Coffee.Config[ 'esp_enabled' ]  ) then 
        return false
    end

    if ( not Coffee.Config[ 'esp_visualize_dead' ] and not Target:Alive( ) ) then 
        return false
    end

    local isLocal = Target == self.Client.Local

    if ( isLocal and not Coffee.Config[ 'esp_local' ] ) then 
        return false
    end

    local isFriendly = Target:Team( ) == self.Client.Team

    if ( not isLocal and isFriendly and not Coffee.Config[ 'esp_team' ] ) then 
        return false
    end

    if ( not isFriendly and not Coffee.Config[ 'esp_enemy' ] ) then 
        return false
    end

    if ( Coffee.Config[ 'esp_culled' ] ) then 
        local Position = Target:GetPos( ):ToScreen( )

        if ( not Position.visible ) then 
            return false
        end
    end

    if ( isLocal and not Coffee.Config[ 'esp_first_person' ] ) then 
        return Coffee.Config[ 'world_thirdperson' ] and self.Menu:Keydown( 'world_thirdperson_keybind' )
    end

    return true
end

function Coffee.Visuals:Wallhack( )
    for k, Target in pairs( self.Records.Players ) do 
        if ( not IsValid( Target ) ) then 
            continue
        end

        if ( not Coffee.Config[ 'esp_enabled' ] or not self.Menu:Keydown( 'esp_enabled_keybind' ) ) then 
            break
        end

        if ( Coffee.Config[ 'esp_limit_distance' ] and self.Client.Position:Distance2D( Target:GetPos( ) ) >= Coffee.Config[ 'esp_limit_distance_distance' ] ) then 
            continue
        end

        if ( not self:Valid( Target ) ) then 
            continue
        end

        -- Reset our offsets.
        self.Offsets = { 
            [ 'Top' ] = 12,
            [ 'Bottom' ] = 4,
            [ 'Right' ] = 0,
            [ 'Left' ] = 0,
            
            [ 'Right Intrinsic' ] = 6,
            [ 'Left Intrinsic' ] = 6
        }

        -- Get front record.
        local Front = Coffee.Config[ 'esp_server' ] and self.Records:GetFront( Target ) or self.Records:Construct( Target, true )
        
        if ( not Front ) then 
            continue
        end

        -- Check dormant.
        if ( Front.Dormant and not Coffee.Config[ 'esp_visualize_dormant' ] ) then 
            continue
        end

        -- Get positional information.
        local Position = Front.Position:ToScreen( )

        self.Position = {
            X = Position.x,
            Y = Position.y
        }

        self.Position.H = Position.y - ( Front.Position + Vector( 0, 0, Front.Maxs.z ) ):ToScreen( ).y
        self.Position.W = self.Position.H / 2

        -- Run our box ESP.
        if ( Coffee.Config[ 'esp_box' ] ) then 
            if ( Coffee.Config[ 'esp_box_type' ] == '2D' ) then 
                surface.SetDrawColor( Coffee.Config[ 'esp_box_color_outline' ] )
                surface.DrawOutlinedRect( self.Position.X - self.Position.W / 2, self.Position.Y - self.Position.H + 2, self.Position.W, self.Position.H, 2 )
            
                surface.SetDrawColor( Front.Dormant and Coffee.Config[ 'esp_visualize_dormant_color' ] or Coffee.Config[ 'esp_box_color' ] )
                surface.DrawOutlinedRect( self.Position.X - self.Position.W / 2, self.Position.Y - self.Position.H + 2, self.Position.W, self.Position.H, 1 )
            
                if ( Coffee.Config[ 'esp_box_fill' ] ) then
                    surface.SetMaterial( self.Menu.Gradients.Up ) 
                    surface.SetDrawColor( Coffee.Config[ 'esp_box_fill_up' ] )
                    surface.DrawTexturedRect( self.Position.X - self.Position.W / 2 + 1, self.Position.Y - self.Position.H + 3, self.Position.W - 2, self.Position.H - 2 )

                    surface.SetMaterial( self.Menu.Gradients.Down ) 
                    surface.SetDrawColor( Coffee.Config[ 'esp_box_fill_down' ] )
                    surface.DrawTexturedRect( self.Position.X - self.Position.W / 2 + 1, self.Position.Y - self.Position.H + 3, self.Position.W - 2, self.Position.H - 2 )
                    
                    draw.NoTexture( )
                end
            else
                cam.Start3D( )
                    render.DrawWireframeBox( Front.Position, angle_zero, Front.Mins, Front.Maxs, Coffee.Config[ 'esp_box_color' ], true )
                cam.End3D( )
            end
        end

        -- Run our healthbar ESP.
        local Health = HSVToColor( math.Clamp( Front.Health / Front.maxHealth, 0, 1 ) * 90, 1, 1 )

        self:RenderBar( self:HandleFillament( Front.Health, Front.maxHealth ), Health, 'esp_healthbar' )

        -- Run our armor ESP.
        if ( Coffee.Config[ 'esp_armorbar_always' ] or Front.Armor > 0 ) then 
            self:RenderBar( self:HandleFillament( Front.Armor, Front.maxArmor ), self.Colors.Cyan, 'esp_armorbar' )

            self:RenderText( Front.Armor, 'esp_armorbar_number' )
        end

        -- Run our healthnumber ESP.
        self:RenderText( math.max( Front.Health, 0 ), 'esp_healthbar_number' )

        -- Run our name ESP.
        self:RenderText( Front.Name, 'esp_name' )

        -- Run our weapon ESP.
        if ( Front.Weapon and Front.Weapon != NULL ) then 
            local Name, Class = 'Unknown', Front.Weapon:GetClass( )

            if ( Coffee.Config[ 'esp_weapon_smart' ] ) then 
                Name = language.GetPhrase( Front.Weapon:GetPrintName( ) )
            else 
                Name = Class
            end

            self:RenderText( Name, 'esp_weapon' )

            local Icon = self.Icons:Get( Front.Weapon, Class )

            if ( Class and Icon ) then 
                self:RenderText( Icon, 'esp_weapon_icon', nil, 'Icons' )
            end
        else 
            self:RenderText( 'Unarmed', 'esp_weapon' )
        end

        -- Run our flag ESP.
        self:RenderText( Front.Ping, 'esp_ping' )

        self:RenderText( Target:GetModel( ) or 'None', 'esp_model' )

        self:RenderText( Target.GetUserGroup and Target:GetUserGroup( ) or 'None', 'esp_usergroup' )
        
        if ( team ) then 
            local Team = team.GetName( Target:Team( ) )

            if ( Team ) then
                self:RenderText( Team != '' and Team or 'None', 'esp_team_name' )
            end
        end

        -- We need to get the current record for these even if server visualization is off.
        local Prediction = self.Records:GetFront( Target ) or Front

        self:RenderText( 'FAKE', 'esp_fake', Prediction.Fake and Coffee.Config[ 'esp_fake_color_bad' ] or Coffee.Config[ 'esp_fake_color_good' ] )
        self:RenderText( 'LC', 'esp_lc', ( Prediction.Shift or Prediction.LC ) and Coffee.Config[ 'esp_lc_color_bad' ] or Coffee.Config[ 'esp_lc_color_good' ] )

        -- If the player is dead and we're visualizing lets add a custom flag.
        if ( not Target:Alive( ) ) then 
            self:RenderText( 'DEAD', 'esp_dead' )
        end

        -- If the player is dormant and we're visualizing lets add a custom flag.
        if ( Target:IsDormant( ) ) then 
            self:RenderText( 'Dormant', 'esp_dormant' )
        end

        -- If we are playing TTT and this player is a terrorist then lets add a custom flag.
        if ( self.Gamemode == 'terrortown' ) then 
            if ( self.Gamemodes:IsDetective( Target ) ) then 
                self:RenderText( 'Detective', 'esp_ttt', Coffee.Config[ 'esp_ttt_detective' ] )
            elseif ( self.Gamemodes:IsTraitor( Target ) ) then
                self:RenderText( 'Traitor', 'esp_ttt', Coffee.Config[ 'esp_ttt_traitor' ] )
            end
        end
		
		-- If player is in build mode.
		if ( Target.buildmode or Target:GetNWBool( 'BuildMode' ) or Target:GetNWBool( '_Kyle_Buildmode' ) ) then 
			self:RenderText( 'Buildmode', 'esp_build_mode', Coffee.Config[ 'esp_build_mode_bad' ] )
		else
			self:RenderText( 'Buildmode', 'esp_build_mode', Coffee.Config[ 'esp_build_mode_good' ] )
		end

        -- Fix our LOD.
        if ( Coffee.Config[ 'esp_lod' ] ) then 
            Target:SetLOD( Coffee.Config[ 'esp_lod_number' ] )
        else
            Target:SetLOD( -1 )
        end

        -- Render our light.
        if ( Coffee.Config[ 'esp_light' ] ) then         
            local Light = DynamicLight( Front.Index, Coffee.Config[ 'esp_light_elight' ] )

            if ( Light ) then 
                Light.pos = Front.Position
                Light.brightness = 2
                Light.decay = 1000
                Light.dietime = CurTime( ) + 1
                Light.style = Coffee.Config[ 'esp_light_flicker' ] and 11 or 0

                local Color = Coffee.Config[ 'esp_light_color' ]

                Light.r = Color.r
                Light.g = Color.g
                Light.b = Color.b

                local Size = ( Coffee.Config[ 'esp_light_size' ] / 100 ) * 4096

                Light.size = Size
            end
        end

        -- Render our ring.
        if ( Coffee.Config[ 'esp_ring' ] ) then 
            local Position = Vector( Front.Position.x, Front.Position.y, Front.Position.z ) 
            
            -- Move the position upwards so that it doesn't clip into the floor.
            Position.z = Position.z + 3
            
            -- Get our end radius.
            local endRadius = Coffee.Config[ 'esp_ring_end_radius' ]

            if ( Coffee.Config[ 'esp_ring_end_radius_pulsate' ] ) then 
                endRadius = math.random( 1, endRadius )
            end

            -- Get our width.
            local Width = Coffee.Config[ 'esp_ring_width' ]

            if ( Coffee.Config[ 'esp_ring_width_pulsate' ] ) then 
                Width = Width + math.sin( CurTime( ) * Width )
            end

            effects.BeamRingPoint( 
                Position,
                3 * ( Coffee.Config[ 'esp_ring_time' ] / 100 ),
                Coffee.Config[ 'esp_ring_start_radius' ],
                endRadius,
                Width,
                Coffee.Config[ 'esp_ring_amplitude' ] / 100,        
                Coffee.Config[ 'esp_ring_color' ],
                {
                    material = 'sprites/lgtning.vmt'
                }
            )
        end

        -- Render our headbeam.
        if ( Coffee.Config[ 'esp_headbeam' ] ) then 
            cam.Start3D( )

            cam.IgnoreZ( true )

            local Eye = Target:EyePos( )

            local Trace = util.TraceLine( {
                start  = Eye,
                endpos = Eye + ( vector_up * 16384 ),
                filter = Target
            } )

            render.SetMaterial( self.Materials:Get( Coffee.Config[ 'esp_headbeam_material' ] ) )

            render.DrawBeam( 
                Trace.StartPos, 
                Trace.HitPos, 
                16, 
                1, 
                1, 
                Coffee.Config[ 'esp_headbeam_color' ] 
            )

            cam.End3D( )
        end

        -- Render our effects.
        if ( Coffee.Config[ 'esp_blink' ] ) then 
            Target:AddEffects( EF_ITEM_BLINK )
        else 
            Target:RemoveEffects( EF_ITEM_BLINK )
        end

        if ( Coffee.Config[ 'esp_remove_shadows' ] ) then 
            Target:AddEffects( EF_NOSHADOW )
        else 
            Target:RemoveEffects( EF_NOSHADOW )
        end

        -- Render our visualized records.
        if ( Coffee.Config[ 'esp_visualized_records' ] ) then 
            -- This aint a very pretty way of doing this...
            local Records = self.Records.Cache[ Target ]

            if ( not Records ) then 
                continue
            end
            
            local Color = Coffee.Config[ 'esp_visualized_records_color' ] 
            local Mode  = Coffee.Config[ 'esp_visualized_records_mode' ]
            
            local Last;

            if ( Mode != 'Dots' ) then 
                cam.Start3D( )
                cam.IgnoreZ( true )
            
                render.SetColorMaterial( )
            end

            if ( Mode != 'Bounds' ) then 
                for k, Record in pairs( Records ) do    
                    if ( not self.Records:Valid( Record ) ) then 
                        continue
                    end
                    
                    if ( Mode == 'Line' and Last ) then
                        render.DrawLine(
                            Record.EyePos,
                            Last.EyePos,
                            Color,
                            true
                        )
                    elseif ( Mode == 'Dots' ) then
                        local Screen = Record.EyePos:ToScreen( )

                        surface.SetDrawColor( 17, 17, 17 )
                        surface.DrawRect( Screen.x, Screen.y, 4, 4 )
                        
                        surface.SetDrawColor( Color )
                        surface.DrawRect( Screen.x + 1, Screen.y + 1, 2, 2 )
                    end
                    
                    Last = Record
                end
            else
                local Record = self.Records:GetLast( Target )

                if ( Record ) then 
                    render.DrawWireframeBox( 
                        Record.Position, 
                        angle_zero, 
                        Record.Mins, 
                        Record.Maxs, 
                        Color, 
                        true 
                    )
                end
            end

            if ( Mode != 'Dots' ) then 
                cam.End3D( )
            end
        end
    end
end