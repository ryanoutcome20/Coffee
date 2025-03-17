-- ambient lighting manip

Coffee.Weather = { 
    Materials = Coffee.Materials,
    Client = Coffee.Client,
    Config = Coffee.Config,

    Particle = {
        [ 'Rain' ] = 'particle/rain_streak',
        [ 'Snow' ] = 'particle/snow'
    },

    Sample = -1,
    Samples = {
        [ 'Rain' ] = 'ambient/weather/rumble_rain_nowind.wav',
        [ 'Snow' ] = 'ambient/wind/wind1.wav',
        [ 'Nature' ] = 'ambient/nature/woodland_ambient_1.wav'
    }
}

function Coffee.Weather:Audio( Enabled, Value )
    if ( self.Sample != -1 ) then 
        self.Client.Local:StopLoopingSound( self.Sample )
    end

    if ( not Enabled ) then 
        return
    end

    self.Sample = self.Client.Local:StartLoopingSound( self.Samples[ Value ] )
end

function Coffee.Weather:GetEmitter( )
    if ( self.Emitter and self.Emitter:IsValid( ) ) then 
        return self.Emitter
    end

    self.Emitter = ParticleEmitter( self.Client.Position )

    return self.Emitter
end

function Coffee.Weather:Particles( )
    if ( not self.Config[ 'world_weather' ] ) then 
        return
    end

    -- Get our position.
    local Position = self.Client.Local:GetPos( )

    -- Adjust based on configuration options.
    local Mode   = self.Config[ 'world_weather_mode' ]
    local Area   = self.Config[ 'world_weather_area' ]
    local Height = self.Config[ 'world_weather_height' ]

    Position = Position + Vector( math.random( -Area, Area ), math.random( -Area, Area ), Height )

    -- Get our emitter.
    local Emitter = self:GetEmitter( )

    if ( not Emitter ) then 
        return
    end

    -- Setup custom particles.
    self.Particle[ 'Custom' ] = self.Config[ 'world_weather_mode_custom' ]

    -- Check trace to see if we are indoors.
    if ( not self.Config[ 'world_weather_indoors' ] ) then
        -- Particles may still pull themselves indoors through velocity but this
        -- is a fine check for basic stuff, also will work to shade the user when
        -- they are COMPLETELY indoors and not just sitting on the edge of a building.
        local Adjusted = Vector( Position.x, Position.y, self.Client.Position.z ) 

        local Trace = util.TraceLine( {
            start  = Adjusted,
            endpos = Adjusted + ( vector_up * 16384 ),
            filter = self.Client.Local
        } )

        -- debugoverlay.Line( Trace.StartPos, Trace.HitPos, 1, Trace.HitSky and Color( 0, 255, 0 ) or Color( 255, 0, 0 ), true )

        if ( not Trace.HitSky ) then 
            return
        end
    end

    -- Create our actual particle and setup our configuration based options.
    local Particle = Emitter:Add( self.Particle[ Mode ], Position )

    if ( not Particle ) then 
        return
    end

    Particle:SetDieTime( 10 )

    Particle:SetStartAlpha( 255 )
    Particle:SetEndAlpha( 0 )

    Particle:SetStartSize( self.Config[ 'world_weather_size' ] )
    Particle:SetEndSize( 0 )

    Particle:SetGravity( vector_up * -self.Config[ 'world_weather_gravity' ] )

    -- Setup velocity.
    local Velocity = VectorRand( )

    if ( self.Config[ 'world_weather_wind' ] ) then 
        Velocity.x = Velocity.x * math.Clamp( self.Config[ 'world_weather_wind_x' ] / 50, 0, 1000 )
        Velocity.y = Velocity.y * math.Clamp( self.Config[ 'world_weather_wind_y' ] / 50, 0, 1000 )
        Velocity.z = Velocity.z * math.Clamp( self.Config[ 'world_weather_wind_z' ] / 50, 0, 1000 )
    end

    Particle:SetVelocity( Velocity * self.Config[ 'world_weather_velocity' ] )

    -- Setup rain specific drag/lengthen.
    if ( Mode == 'Rain' ) then 
        Particle:SetStartLength( 25 )
        Particle:SetEndLength( 25 )
    end
end

Coffee.Hooks:New( 'Think', Coffee.Weather.Particles, Coffee.Weather )