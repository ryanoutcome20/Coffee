function Coffee.Visuals:PreImpacts( ENT, Data )
    local Trace = util.TraceLine( { 
        start  = Data.Src, 
        endpos = Data.Src + ( Data.Dir * Data.Distance ),
        filter = { self.Client.Local }, 
        mask = MASK_SHOT
    } )

    if ( self.Config[ 'world_impacts' ] ) then 
        local Time = 3 * ( self.Config[ 'world_impacts_time' ] / 100 )

        self.Overlay:Box( Trace.HitPos, nil, nil, Time, self.Config[ 'world_impacts_client' ] )
    end
end

function Coffee.Visuals:PostImpacts( ENT, Data )
    if ( ENT != self.Client.Local ) then 
        return
    end

    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return
    end

    if ( not Data.Trace.Hit ) then 
        return
    end

    -- Render our impact boxes.
    if ( self.Config[ 'world_impacts' ] ) then 
        local Time = 3 * ( self.Config[ 'world_impacts_time' ] / 100 )
    
        self.Overlay:Box( Data.Trace.HitPos, nil, nil, Time, self.Config[ 'world_impacts_server' ] )

        if ( self.Config[ 'world_impacts_spreadless' ] ) then 
            local Trace = self.Client.Local:GetEyeTrace( )

            self.Overlay:Box( Trace.HitPos, nil, nil, Time, self.Config[ 'world_impacts_spreadless_color' ] )
        end
    end

    -- Check if we are rendering a beam.
    if ( not self.Config[ 'world_beams' ] ) then 
        return
    end
    
    -- Get our render color.
    local Colors = {
        Main      = self.Config[ 'world_beams_normal_main' ],
        Secondary = self.Config[ 'world_beams_normal_secondary' ]
    }

    if ( Data.Trace.Entity:IsPlayer( ) or Data.Trace.Entity:IsNPC( ) ) then 
        Colors = {
            Main      = self.Config[ 'world_beams_hurt_main' ],
            Secondary = self.Config[ 'world_beams_hurt_secondary' ]
        }
    end

    -- Check if we're using a traced line.
    local Trace = Data.Trace 

    if ( self.Config[ 'world_beams_traced' ] ) then 
        Trace = self.Client.Local:GetEyeTrace( )
    end

    -- Call our overlay handler.
    self.Overlay:Beam( 
        Trace.StartPos,
        Trace.HitPos,
        3 * ( self.Config[ 'world_beams_time' ] / 100 ),
        self.Config[ 'world_beams_width' ],
        self.Config[ 'world_beams_speed' ] / 100,
        self.Config[ 'world_beams_amplitude' ] / 100,
        self.Config[ 'world_beams_twist' ] * 10,
        self.Config[ 'world_beams_cone' ] / 100,
        self.Config[ 'world_beams_segments' ],
        self.Materials:Get( 'Physbeam' ),
        Colors.Main,
        Colors.Secondary,
        false
    )
end

Coffee.Hooks:New( 'PostEntityFireBullets', Coffee.Visuals.PostImpacts, Coffee.Visuals )
Coffee.Hooks:New( 'EntityFireBullets', Coffee.Visuals.PreImpacts, Coffee.Visuals )