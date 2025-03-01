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
end

Coffee.Hooks:New( 'PlayerFootstep', Coffee.Visuals.Footsteps, Coffee.Visuals )