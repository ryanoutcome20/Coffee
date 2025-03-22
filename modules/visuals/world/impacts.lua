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
    
    -- Check if we're using a traced line.
    local Trace = Data.Trace 

    if ( self.Config[ 'world_beams_traced' ] ) then 
        Trace = self.Client.Local:GetEyeTrace( )
    end

    -- Get our render color.
    local Colors = {
        Main      = self.Config[ 'world_beams_normal_main' ],
        Secondary = self.Config[ 'world_beams_normal_secondary' ]
    }

    if ( Trace.Entity:IsPlayer( ) or Trace.Entity:IsNPC( ) ) then 
        Colors = {
            Main      = self.Config[ 'world_beams_hurt_main' ],
            Secondary = self.Config[ 'world_beams_hurt_secondary' ]
        }
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
        self.Materials:Get( self.Config[ 'world_beams_material' ] ),
        Colors.Main,
        Colors.Secondary,
        false
    )
end

function Coffee.Visuals:ImpactEffects( Data )
    local Victim = Player( Data.userid )
    local Inflictor = Player( Data.attacker )
        
    if ( Victim == Inflictor or Inflictor != self.Client.Local ) then 
        return
    end

    -- Get lethal.
    local Lethal = Data.health <= 0

    -- Add hitsound.
    if ( self.Config[ 'world_hitsound' ] ) then
        for i = 1, self.Config[ 'world_hitsound_passes' ] do
            self.Client.Local:EmitSound(
                self.Config[ 'world_hitsound_sound' ],
                511,
                100,
                self.Config[ 'world_hitsound_volume' ] / 100,
                CHAN_STATIC,
                SND_NOFLAGS
            )
        end
    end

    -- Add hitmarker.
    self.Hitmarker:New( self.Config[ 'world_hitmarker_time' ] )

    -- Add our hit effect.
    if ( not self.Config[ 'world_effects' ] ) then 
        return
    end

    -- Setup our effect data.
    local Effect = EffectData( )

    Effect:SetOrigin( Victim:GetPos( ) + Victim:OBBCenter( ) )
    Effect:SetEntity( Victim )
    
    Effect:SetMagnitude( self.Config[ 'world_effects_magnitude' ] )
    Effect:SetRadius( self.Config[ 'world_effects_radius' ] )
    Effect:SetScale( self.Config[ 'world_effects_scale' ] )

    -- Check if we need to remove the sound and smoke.
    Effect:SetFlags( self.Config[ 'world_effects_no_flags' ] and 0x0 or 0x84 )

    -- Setup our style.
    local Style = Lethal and self.Config[ 'world_effects_kill' ] or self.Config[ 'world_effects_hurt' ]
    
    self.Effects[ 'Custom' ] = Lethal and self.Config[ 'world_effects_kill_custom' ] or self.Config[ 'world_effects_hurt_custom' ]

    -- Load our effect.
    util.Effect( self.Effects[ Style ], Effect )
end

gameevent.Listen( 'player_hurt' )

Coffee.Hooks:New( 'PostEntityFireBullets', Coffee.Visuals.PostImpacts, Coffee.Visuals )
Coffee.Hooks:New( 'EntityFireBullets', Coffee.Visuals.PreImpacts, Coffee.Visuals )
Coffee.Hooks:New( 'player_hurt', Coffee.Visuals.ImpactEffects, Coffee.Visuals )