function Coffee.Visuals:Glow( )
    for k, Target in pairs( self.Records.Players ) do 
        if ( not self.Config[ 'esp_enabled' ] or not self.Menu:Keydown( 'esp_enabled_keybind' ) ) then 
            break
        end

        if ( not self.Config[ 'esp_glow' ] ) then 
            break
        end

        if ( not self:Valid( Target ) ) then 
            continue
        end

        -- Get front record.
        local Front = self.Config[ 'esp_server' ] and self.Records:GetFront( Target ) or self.Records:Construct( Target )

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

        -- Add halo information to the render buffer.
        halo.Add( Targets, self.Config[ 'esp_glow_color' ], 1, 1, self.Config[ 'esp_glow_passes' ], not self.Config[ 'esp_glow_bloom' ], true )
    end
end

Coffee.Hooks:New( 'PreDrawHalos', Coffee.Visuals.Glow, Coffee.Visuals )