function Coffee.Visuals:Valid( Target )
    if ( not self.Config[ 'esp_enabled' ]  ) then 
        return false
    end

    if ( not self.Config[ 'esp_visualize_dead' ] and not Target:Alive( ) ) then 
        return false
    end

    local isLocal = Target == self.Client.Local

    if ( isLocal and not self.Config[ 'esp_local' ] ) then 
        return false
    end

    local isFriendly = Target:Team( ) == self.Client.Team

    if ( not isLocal and isFriendly and not self.Config[ 'esp_team' ] ) then 
        return false
    end

    if ( not isFriendly and not self.Config[ 'esp_enemy' ] ) then 
        return false
    end

    return true
end

function Coffee.Visuals:Wallhack( )
    local Distance = self.Client.Position

    for k, Target in pairs( self.Records.Players ) do 
        if ( not self.Config[ 'esp_enabled' ] or not self.Menu:Keydown( 'esp_enabled_keybind' ) ) then 
            break
        end

        if ( self.Config[ 'esp_limit_distance' ] and Distance:Distance2D( Target:GetPos( ) ) >= self.Config[ 'esp_limit_distance_distance' ] ) then 
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
        local Front = self.Config[ 'esp_server' ] and self.Records:GetFront( Target ) or self.Records:Construct( Target, true )
        
        if ( not Front ) then 
            continue
        end

        -- Check dormant.
        if ( Front.Dormant and not self.Config[ 'esp_visualize_dormant' ] ) then 
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
        if ( self.Config[ 'esp_box' ] ) then 
            if ( self.Config[ 'esp_box_type' ] == '2D' ) then 
                surface.SetDrawColor( self.Config[ 'esp_box_color_outline' ] )
                surface.DrawOutlinedRect( self.Position.X - self.Position.W / 2, self.Position.Y - self.Position.H + 2, self.Position.W, self.Position.H, 2 )
            
                surface.SetDrawColor( Front.Dormant and self.Config[ 'esp_visualize_dormant_color' ] or self.Config[ 'esp_box_color' ] )
                surface.DrawOutlinedRect( self.Position.X - self.Position.W / 2, self.Position.Y - self.Position.H + 2, self.Position.W, self.Position.H, 1 )
            
                if ( self.Config[ 'esp_box_fill' ] ) then
                    surface.SetMaterial( self.Menu.Gradients.Up ) 
                    surface.SetDrawColor( self.Config[ 'esp_box_fill_up' ] )
                    surface.DrawTexturedRect( self.Position.X - self.Position.W / 2 + 1, self.Position.Y - self.Position.H + 3, self.Position.W - 2, self.Position.H - 2 )

                    surface.SetMaterial( self.Menu.Gradients.Down ) 
                    surface.SetDrawColor( self.Config[ 'esp_box_fill_down' ] )
                    surface.DrawTexturedRect( self.Position.X - self.Position.W / 2 + 1, self.Position.Y - self.Position.H + 3, self.Position.W - 2, self.Position.H - 2 )
                    
                    draw.NoTexture( )
                end
            else
                cam.Start3D( )
                    render.DrawWireframeBox( Front.Position, angle_zero, Front.Mins, Front.Maxs, self.Config[ 'esp_box_color' ], true )
                cam.End3D( )
            end
        end

        -- Run our healthbar ESP.
        local Health = HSVToColor( math.Clamp( Front.Health / Front.maxHealth, 0, 1 ) * 90, 1, 1 )

        self:RenderBar( self:HandleFillament( Front.Health, Front.maxHealth ), Health, 'esp_healthbar' )

        -- Run our armor ESP.
        if ( self.Config[ 'esp_armorbar_always' ] or Front.Armor > 0 ) then 
            self:RenderBar( self:HandleFillament( Front.Armor, Front.maxArmor ), nil, 'esp_armorbar' )

            self:RenderText( Front.Armor, 'esp_armorbar_number' )
        end

        -- Run our healthnumber ESP.
        self:RenderText( math.max( Front.Health, 0 ), 'esp_healthbar_number' )

        -- Run our name ESP.
        self:RenderText( Front.Name, 'esp_name' )

        -- Run our weapon ESP.
        if ( Front.Weapon and Front.Weapon != NULL ) then 
            local Name = 'Unknown'

            if ( self.Config[ 'esp_weapon_smart' ] ) then 
                Name = language.GetPhrase( Front.Weapon:GetPrintName( ) )
            else 
                Name = Front.Weapon:GetClass( ) 
            end

            self:RenderText( Name, 'esp_weapon' )
        else 
            self:RenderText( 'Unarmed', 'esp_weapon' )
        end

        -- Run our flag ESP.
        self:RenderText( Front.Ping, 'esp_ping' )

        self:RenderText( Target.GetUserGroup and Target:GetUserGroup( ) or 'none', 'esp_usergroup' )
        
        if ( team ) then 
            local Team = team.GetName( Target.Team )

            if ( Team ) then
                self:RenderText( Team != '' and Team or 'none', 'esp_team_name' )
            end
        end

        -- We need to get the current record for these even if server visualization is off.
        local Prediction = self.Records:GetFront( Target ) or Front

        self:RenderText( 'FAKE', 'esp_fake', Prediction.Fake and self.Config[ 'esp_fake_color_bad' ] or self.Config[ 'esp_fake_color_good' ] )
        self:RenderText( 'LC', 'esp_lc', ( Prediction.Shift or Prediction.LC ) and self.Config[ 'esp_lc_color_bad' ] or self.Config[ 'esp_lc_color_good' ] )

        -- If the player is dead and we're visualizing lets add a custom flag.
        if ( not Target:Alive( ) ) then 
            self:RenderText( 'DEAD', 'esp_dead' )
        end

        -- Fix our LOD.
        if ( self.Config[ 'esp_lod' ] ) then 
            Target:SetLOD( self.Config[ 'esp_lod_number' ] )
        else
            Target:SetLOD( -1 )
        end

        -- Render our light.
        if ( self.Config[ 'esp_light' ] ) then         
            local Light = DynamicLight( Front.Index, self.Config[ 'esp_light_elight' ] )

            if ( Light ) then 
                Light.pos = Front.Position
                Light.brightness = 2
                Light.decay = 1000
                Light.dietime = CurTime( ) + 1
                Light.style = self.Config[ 'esp_light_flicker' ] and 11 or 0

                local Color = self.Config[ 'esp_light_color' ]

                Light.r = Color.r
                Light.g = Color.g
                Light.b = Color.b

                local Size = ( self.Config[ 'esp_light_size' ] / 100 ) * 4096

                Light.size = Size
            end
        end

        -- Render our ring.
        if ( self.Config[ 'esp_ring' ] ) then 
            local Position = Vector( Front.Position.x, Front.Position.y, Front.Position.z ) 
            
            -- Move the position upwards so that it doesn't clip into the floor.
            Position.z = Position.z + 3
            
            -- Get our end radius.
            local endRadius = self.Config[ 'esp_ring_end_radius' ]

            if ( self.Config[ 'esp_ring_end_radius_pulsate' ] ) then 
                endRadius = math.random( 1, endRadius )
            end

            -- Get our width.
            local Width = self.Config[ 'esp_ring_width' ]

            if ( self.Config[ 'esp_ring_width_pulsate' ] ) then 
                Width = Width + math.sin( CurTime( ) * Width )
            end

            effects.BeamRingPoint( 
                Position,
                3 * ( self.Config[ 'esp_ring_time' ] / 100 ),
                self.Config[ 'esp_ring_start_radius' ],
                endRadius,
                Width,
                self.Config[ 'esp_ring_amplitude' ] / 100,        
                self.Config[ 'esp_ring_color' ],
                {
                    material = 'sprites/lgtning.vmt'
                }
            )
        end

        -- Render our effects.
        if ( self.Config[ 'esp_blink' ] ) then 
            Target:AddEffects( EF_ITEM_BLINK )
        else 
            Target:RemoveEffects( EF_ITEM_BLINK )
        end

        if ( self.Config[ 'esp_remove_shadows' ] ) then 
            Target:AddEffects( EF_NOSHADOW )
        else 
            Target:RemoveEffects( EF_NOSHADOW )
        end
    end
end