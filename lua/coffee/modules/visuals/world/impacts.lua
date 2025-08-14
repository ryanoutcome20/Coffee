function Coffee.Visuals:PreImpacts( ENT, Data )
    local Trace = util.TraceLine( { 
        start  = Data.Src, 
        endpos = Data.Src + ( Data.Dir * Data.Distance ),
        filter = { self.Client.Local }, 
        mask = MASK_SHOT
    } )

    if ( Coffee.Config[ 'world_impacts' ] ) then 
        local Time = 3 * ( Coffee.Config[ 'world_impacts_time' ] / 100 )

        self.Overlay:Box( Trace.HitPos, nil, nil, Time, Coffee.Config[ 'world_impacts_client' ] )
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
    if ( Coffee.Config[ 'world_impacts' ] ) then 
        local Time = 3 * ( Coffee.Config[ 'world_impacts_time' ] / 100 )
    
        self.Overlay:Box( Data.Trace.HitPos, nil, nil, Time, Coffee.Config[ 'world_impacts_server' ] )

        if ( Coffee.Config[ 'world_impacts_spreadless' ] ) then 
            local Trace = self.Client.Local:GetEyeTrace( )

            self.Overlay:Box( Trace.HitPos, nil, nil, Time, Coffee.Config[ 'world_impacts_spreadless_color' ] )
        end
    end

    -- Check if we are rendering a beam.
    if ( not Coffee.Config[ 'world_beams' ] ) then 
        return
    end
    
    -- Check if we're using a traced line.
    local Trace = Data.Trace 

    if ( Coffee.Config[ 'world_beams_traced' ] ) then 
        Trace = self.Client.Local:GetEyeTrace( )
    end

    -- Get our render color.
    local Colors = {
        Main      = Coffee.Config[ 'world_beams_normal_main' ],
        Secondary = Coffee.Config[ 'world_beams_normal_secondary' ]
    }

    if ( Trace.Entity:IsPlayer( ) or Trace.Entity:IsNPC( ) ) then 
        Colors = {
            Main      = Coffee.Config[ 'world_beams_hurt_main' ],
            Secondary = Coffee.Config[ 'world_beams_hurt_secondary' ]
        }
    end

    -- Call our overlay handler.
    self.Overlay:Beam( 
        Trace.StartPos,
        Trace.HitPos,
        3 * ( Coffee.Config[ 'world_beams_time' ] / 100 ),
        Coffee.Config[ 'world_beams_width' ],
        Coffee.Config[ 'world_beams_speed' ] / 100,
        Coffee.Config[ 'world_beams_amplitude' ] / 100,
        Coffee.Config[ 'world_beams_twist' ] * 10,
        Coffee.Config[ 'world_beams_cone' ] / 100,
        Coffee.Config[ 'world_beams_segments' ],
        self.Materials:Get( Coffee.Config[ 'world_beams_material' ] ),
        Colors.Main,
        Colors.Secondary,
        false
    )
end

function Coffee.Visuals:ImpactEffects( Data )
    local Victim = Player( Data.userid )
    local Inflictor = Player( Data.attacker )
        
    if ( not IsValid( Victim ) or not IsValid( Inflictor ) ) then 
        return
    end

    if ( Victim == Inflictor or Inflictor != self.Client.Local ) then 
        return
    end

    -- Get lethal.
    local Lethal = Data.health <= 0

    -- Add hitsound.
    if ( Lethal and Coffee.Config[ 'world_killsound' ] ) then 
        local Sound, Volume = Coffee.Config[ 'world_killsound_sound' ], Coffee.Config[ 'world_killsound_volume' ] / 100

        for i = 1, Coffee.Config[ 'world_killsound_passes' ] do
            self.Client.Local:EmitSound(
                Sound,
                511,
                100,
                Volume,
                CHAN_STATIC,
                SND_NOFLAGS
            )
        end
    elseif ( Coffee.Config[ 'world_hitsound' ] ) then
        local Sound, Volume = Coffee.Config[ 'world_hitsound_sound' ], Coffee.Config[ 'world_hitsound_volume' ] / 100

        for i = 1, Coffee.Config[ 'world_hitsound_passes' ] do
            self.Client.Local:EmitSound(
                Sound,
                511,
                100,
                Volume,
                CHAN_STATIC,
                SND_NOFLAGS
            )
        end
    end

    -- Add hitmarker.
    self.Hitmarker:New( Coffee.Config[ 'world_hitmarker_time' ] )

    -- Add our hit effect.
    if ( not Coffee.Config[ 'world_effects' ] ) then 
        return
    end

    -- Setup our effect data.
    local Effect = EffectData( )

    Effect:SetOrigin( Victim:GetPos( ) + Victim:OBBCenter( ) )
    Effect:SetEntity( Victim )
    
    Effect:SetMagnitude( Coffee.Config[ 'world_effects_magnitude' ] )
    Effect:SetRadius( Coffee.Config[ 'world_effects_radius' ] )
    Effect:SetScale( Coffee.Config[ 'world_effects_scale' ] )

    -- Check if we need to remove the sound and smoke.
    Effect:SetFlags( Coffee.Config[ 'world_effects_no_flags' ] and 0x0 or 0x84 )

    -- Setup our style.
    local Style = Lethal and Coffee.Config[ 'world_effects_kill' ] or Coffee.Config[ 'world_effects_hurt' ]
    
    self.Effects[ 'Custom' ] = Lethal and Coffee.Config[ 'world_effects_kill_custom' ] or Coffee.Config[ 'world_effects_hurt_custom' ]

    -- Load our effect.
    util.Effect( self.Effects[ Style ], Effect )
end

gameevent.Listen( 'player_hurt' )

Coffee.Hooks:New( 'PostEntityFireBullets', Coffee.Visuals.PostImpacts, Coffee.Visuals )
Coffee.Hooks:New( 'EntityFireBullets', Coffee.Visuals.PreImpacts, Coffee.Visuals )
Coffee.Hooks:New( 'player_hurt', Coffee.Visuals.ImpactEffects, Coffee.Visuals )