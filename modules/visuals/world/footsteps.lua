function Coffee.Visuals:Footsteps( ENT, Position, Foot, Sound, Volume, Filter )
    if ( self.Config[ 'esp_footstep_visualize' ] ) then
        -- Get color.
        local Color = Foot == 0 and self.Config[ 'esp_footstep_visualize_left' ] or self.Config[ 'esp_footstep_visualize_right' ]
        
        -- Move the position upwards so that it doesn't clip into the floor.
        Position.z = Position.z + 3
        
        -- Run our beampoint effect.
        effects.BeamRingPoint( Position, 0.5, 0, 120, 2, 0, Color, { 
            framerate = 2, 
            material  = 'sprites/lgtning.vmt' 
        } )
    end

    if ( not self.Config[ 'world_footstep' ] ) then 
        return
    end

    local DSP    = self.Config[ 'world_footstep_dsp' ] and self.Config[ 'world_footstep_dsp_index' ] or 0
    local Level  = self.Config[ 'world_footstep_range' ] and 180 or 75
    local Volume = 1

    if ( self.Client.Local == ENT ) then 
        if ( self.Config[ 'world_footstep_local_suppress' ] ) then 
            return true
        end

        Volume = self.Config[ 'world_footstep_local_volume' ] / 100
    else
        if ( self.Config[ 'world_footstep_other_suppress' ] ) then 
            return true
        end

        Volume = self.Config[ 'world_footstep_other_volume' ] / 100
    end

    ENT:EmitSound( Sound, Level, 100, Volume, CHAN_AUTO, SND_NOFLAGS, DSP )

    return true
end

Coffee.Hooks:New( 'PlayerFootstep', Coffee.Visuals.Footsteps, Coffee.Visuals )