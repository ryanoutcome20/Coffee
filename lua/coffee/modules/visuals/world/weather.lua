-- ambient lighting manip

Coffee.Weather = { 
    Materials = Coffee.Materials,
    Client = Coffee.Client,
	
    World = game.GetWorld( ),

    Particle = {
        [ 'Rain' ] = 'particle/rain_streak',
        [ 'Snow' ] = 'particle/snow'
    },

    Samples = {
        [ 'Rain' ] = 'ambient/weather/rumble_rain_nowind.wav',
        [ 'Snow' ] = 'ambient/wind/wind1.wav',
        [ 'Nature' ] = 'ambient/nature/woodland_ambient_1.wav'
    }
}

function Coffee.Weather:ResetAudio( )
    if ( self.Object ) then 
        self.Object:Stop( )
    end

    self.Object = nil
end

function Coffee.Weather:Audio( )
    if ( not Coffee.Config[ 'world_weather_audio' ] ) then 
        self:ResetAudio( )
        return
    end

    local Mode = self.Samples[ Coffee.Config[ 'world_weather_audio_mode' ] ]

    if ( self.Current != Mode ) then 
        self:ResetAudio( )
    end

    if ( not self.Object ) then 
        self.Object = CreateSound( self.World, Mode )
    end

    self.Object:SetSoundLevel( 0 )

    -- Don't just check if its running and then play it here since it adds easily identifiable tick
    -- noises when it switches between two objects.
    self.Object:PlayEx( 
        Coffee.Config[ 'world_weather_audio_volume' ] / 100, 
        Coffee.Config[ 'world_weather_audio_pitch' ] 
    )    

    self.Current = Mode
end

function Coffee.Weather:GetEmitter( )
    if ( self.Emitter and self.Emitter:IsValid( ) ) then 
        return self.Emitter
    end

    self.Emitter = ParticleEmitter( self.Client.Position )

    return self.Emitter
end

function Coffee.Weather:Indoors( Position )
    -- Check trace to see if we are indoors.
    if ( not Coffee.Config[ 'world_weather_indoors' ] ) then
        -- Particles may still pull themselves indoors through velocity but this
        -- is a fine check for basic stuff, also will work to shade the user when
        -- they are COMPLETELY indoors and not just sitting on the edge of a building.
        local Adjusted = Vector( Position.x, Position.y, self.Client.Position.z ) 

        local Trace = util.TraceLine( {
            start  = Adjusted,
            endpos = Adjusted + ( vector_up * 16384 ),
            filter = self.Client.Local
        } )
        
        if ( Coffee.Config[ 'world_weather_textureless' ] and Trace.HitTexture == '**empty**' ) then 
            Trace.HitSky = true
        end

        if ( not Trace.HitSky ) then 
            return true
        end
    end

    return false
end

function Coffee.Weather:Wind( Velocity, Height )
    self.windDirection = self.windDirection or vector_origin

    if ( not Coffee.Config[ 'world_weather_wind' ] ) then 
        return Velocity    
    end

    local Time = CurTime( ) 
  
    self.windDirection.x = Lerp( 
        0.1, 
        self.windDirection.x, 
        math.sin( Time * Coffee.Config[ 'world_weather_wind_timescale_x' ] ) * Coffee.Config[ 'world_weather_wind_x' ] 
    )

    self.windDirection.y = Lerp( 
        0.1, 
        self.windDirection.y, 
        math.cos( Time * Coffee.Config[ 'world_weather_wind_timescale_y' ] ) * Coffee.Config[ 'world_weather_wind_y' ] 
    )

    self.windDirection.z = Lerp( 
        0.1, 
        self.windDirection.z, 
        math.sin( Time * Coffee.Config[ 'world_weather_wind_timescale_z' ] ) * Coffee.Config[ 'world_weather_wind_z' ] 
    )

    if ( Coffee.Config[ 'world_weather_wind_turbulence' ] ) then 
        self.windDirection = self.windDirection + VectorRand( ) * Coffee.Config[ 'world_weather_wind_turbulence_scale' ]
    end

    return self.windDirection * Velocity
end

function Coffee.Weather:Particles( )
    if ( not Coffee.Config[ 'world_weather' ] ) then 
        return
    end

    -- Get our position.
    local Position = self.Client.Local:GetPos( )

    -- Adjust based on configuration options.
    local Mode   = Coffee.Config[ 'world_weather_mode' ]
    local Area   = Coffee.Config[ 'world_weather_area' ]
    local Height = Coffee.Config[ 'world_weather_height' ]

    Position = Position + Vector( math.random( -Area, Area ), math.random( -Area, Area ), Height )

    -- Get our emitter.
    local Emitter = self:GetEmitter( )

    if ( not Emitter ) then 
        return
    end

    -- Setup custom particles.
    self.Particle[ 'Custom' ] = Coffee.Config[ 'world_weather_mode_custom' ]

    -- Check trace to see if we are indoors.
    if ( self:Indoors( Position ) ) then 
        return
    end

    -- Create our actual particle and setup our configuration based options.
    local Particle = Emitter:Add( self.Particle[ Mode ], Position )

    if ( not Particle ) then 
        return
    end

    Particle:SetDieTime( 10 )

    Particle:SetStartAlpha( 255 )
    Particle:SetEndAlpha( 0 )

    Particle:SetStartSize( Coffee.Config[ 'world_weather_size' ] )
    Particle:SetEndSize( 0 )

    Particle:SetGravity( vector_up * -Coffee.Config[ 'world_weather_gravity' ] )

    -- Setup color.
    local Color = Coffee.Config[ 'world_weather_color' ]

    Particle:SetColor( Color.r, Color.g, Color.b )

    -- Setup velocity.
    Particle:SetVelocity( self:Wind( VectorRand( ), Height ) * Coffee.Config[ 'world_weather_velocity' ] )

    -- Setup roll.
    if ( Coffee.Config[ 'world_weather_roll' ] ) then 
        local Target = Coffee.Config[ 'world_weather_roll_target' ]
        local Delta  = Coffee.Config[ 'world_weather_roll_delta' ]
        
        Particle:SetRoll( math.random( -Target, Target ) )
        Particle:SetRollDelta( math.Rand( -Delta, Delta ) )
    end

    -- Setup per particle traces.
    if ( Coffee.Config[ 'world_weather_per_particle' ] ) then 
        Particle:SetNextThink( CurTime( ) )

        Particle:SetThinkFunction( function( self )
            if ( Coffee.Weather:Indoors( self:GetPos( ) ) ) then 
                self:SetDieTime( 0 )
            end

            self:SetNextThink( CurTime( ) )
        end )
    end

    -- Setup rain specific drag/lengthen.
    if ( Mode == 'Rain' ) then 
        Particle:SetStartLength( 25 )
        Particle:SetEndLength( 25 )
    end
end

Coffee.Hooks:New( 'Think', Coffee.Weather.Particles, Coffee.Weather )
Coffee.Hooks:New( 'Tick', Coffee.Weather.Audio, Coffee.Weather )