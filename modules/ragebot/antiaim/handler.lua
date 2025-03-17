function Coffee.Ragebot:GetYawBase( )
    local Mode = self.Config[ 'hvh_yaw_base' ]

    if ( Mode == 'Crosshair' ) then 
        return self.Silent.y
    elseif ( Mode == 'Distance' ) then 
        for k, Target in pairs( player.GetAll( ) ) do 
            if ( self:Valid( Target ) ) then 
                return ( Target:GetPos( ) - self.Client.Position ):Angle( ).y
            end
        end
    end

    return 0 
end

function Coffee.Ragebot:GetTiming( Timer )
    if ( Timer == 'Current Time' ) then 
        return CurTime( )
    end

    return SysTime( )
end

function Coffee.Ragebot:GetTrigonometric( Function )
    if ( Function == 'Sine' ) then 
        return math.sin
    elseif ( Function == 'Cosine' ) then 
        return math.cos
    end

    return math.tan
end

function Coffee.Ragebot:GetDistortion( Base )
    if ( not self.Config[ 'hvh_yaw_distortion' ] ) then 
        return Base
    end

    local Time = self:GetTiming( self.Config[ 'hvh_yaw_distortion_timer' ] )
    local Trigonometric = self:GetTrigonometric( self.Config[ 'hvh_yaw_distortion_trigonometric' ] )
    local Divisor = self.Config[ 'hvh_yaw_distortion_divisor' ]

    -- Calculate distortion.
    local Distortion = Trigonometric( Time * self.Config[ 'hvh_yaw_distortion_speed' ] / Divisor ) * Base
    
    -- Calculate forced distortion.
    if ( self.Config[ 'hvh_yaw_distortion_force' ] ) then 
        Distortion = Distortion + ( 360 * ( math.abs( Divisor ) / Divisor ) )
    end

    return Distortion
end

function Coffee.Ragebot:GetFakeFlick( Base )
    if ( not self.Config[ 'hvh_yaw_flick' ] ) then 
        return Base
    end

    local Time = self:GetTiming( self.Config[ 'hvh_yaw_flick_timer' ] )
    local Trigonometric = self:GetTrigonometric( self.Config[ 'hvh_yaw_flick_trigonometric' ] )

    -- Get flick speed.
    local Speed = self.Config[ 'hvh_yaw_flick_speed' ] + 50

    -- Get flick angle.
    local Angle = self.Config[ 'hvh_yaw_flick_angle' ]

    if ( self.Config[ 'hvh_yaw_flick_desync' ] ) then 
        Angle = ( Time % 4 ) * Angle
    end

    -- Calculate final angle.
    Angle = Base + ( Angle + Trigonometric( Time * Speed ) )

    return Angle
end

function Coffee.Ragebot:GetJitter( Base )
    if ( not self.Config[ 'hvh_jitter' ] ) then 
        return Base
    end

    self.Jitter = self.Jitter or 0

    local Amount = self.Config[ 'hvh_jitter_angle' ] 

    if ( self.Jitter == 0 ) then 
        Base = Base + Amount
    elseif ( self.Jitter == 1 ) then
        Base = Base - Amount
    end

    self.Jitter = ( self.Jitter + 1 ) % ( self.Config[ 'hvh_jitter_center' ] and 3 or 2 )

    return Base
end

function Coffee.Ragebot:GetYaw( )
    local Base = self:GetYawBase( ) + self.Config[ 'hvh_yaw_add' ]

    -- Apply jitter.
    Base = self:GetJitter( Base ) 

    -- Apply distortion.
    Base = self:GetDistortion( Base )

    -- Apply fake flick.
    Base = self:GetFakeFlick( Base )

    -- Invert if needed.
    if ( self.Menu:Keydown( 'hvh_yaw_invert' ) ) then 
        Base = Base + 180
    end

    return math.NormalizeAngle( Base )
end

function Coffee.Ragebot:GetPitch( )
    local Angles = {
        [ 'Emotion' ]   = 89,
        [ 'Up' ]        = -89,
        [ 'Down' ]      = 91,
        [ 'Zero' ]      = 0,
        [ 'Fake Down' ] = 180,
        [ 'Fake Up' ]   = -180,
        [ 'Fake Jitter' ] = math.random( ) >= 0.5 and -180 or 180
    }

    return Angles[ self.Config[ 'hvh_pitch_mode' ] ]
end

function Coffee.Ragebot:AntiAim( CUserCMD )
    if ( not self.Config[ 'hvh_enabled' ] ) then 
        return
    end

    if ( self.Client.Movetype == MOVETYPE_NOCLIP or self.Client.Movetype == MOVETYPE_LADDER ) then 
        return
    end

    if ( CUserCMD:KeyDown( IN_ATTACK ) or CUserCMD:KeyDown( IN_USE ) ) then 
        return
    end
    
    -- Get current angles.
    self.Fake = Angle( 0, self.Real.y, 0 )
    self.Real = CUserCMD:GetViewAngles( )

    -- Get pitch.
    local Pitch = self.Config[ 'hvh_pitch' ] and self:GetPitch( ) or self.Real.x

    -- Get yaw.
    local Yaw = self.Config[ 'hvh_yaw' ] and self:GetYaw( ) or self.Real.y

    -- Set our angles.
    self.Real = Angle( Pitch, Yaw, 0 )

    -- Set angles.
    CUserCMD:SetViewAngles( self.Real )

    -- Check if we need to flip packets.
    if ( self.Config[ 'hvh_yaw_flip_packets' ] and not self.isManipulating ) then
        self.Packet = not self.Packet
        
        if ( self.Choked >= 23 ) then 
            self.Packet = true
        end
    end

    -- Generate our true fake angle.
    -- Our fake angle won't show desync for some reason, fix later?
    self.Fake.x = self.Real.x

    if ( self.Real.x == -180 ) then
        self.Fake.x = 180
    end
end

function Coffee.Ragebot:Fakelag( CUserCMD )
    if ( self.isManipulating ) then 
        return
    end

    if ( self.Config[ 'hvh_fakelag' ] and self.Choked <= self.Config[ 'hvh_fakelag_ticks' ] ) then 
        self.Packet = false
    end

    if ( self.Client.Alive ) then 
        if ( not self.Config[ 'hvh_fakelag_shots' ] and CUserCMD:KeyDown( IN_ATTACK ) ) then 
            self.Packet = true
        end
    else 
        self.Packet = true
    end
end

function Coffee.Ragebot:Speedhack( CUserCMD )
    if ( not self.Config[ 'hvh_speedhack' ] or not self.Menu:Keydown( 'hvh_speedhack_keybind' ) ) then 
        return
    end

    local Ticks = self.Config[ 'hvh_speedhack_ticks' ]

    if ( self.Config[ 'hvh_speedhack_airstuck' ] ) then 
        -- This only works if sv_maxusrcmdprocessticks is set to a number other than zero since
        -- it relies entirely on the server holding you in place.
        Ticks = Ticks * 10
    end

    self.Require:SetOutSequence( self.Require:GetOutSequence( ) + Ticks )

    self.isManipulating = true
end 

function Coffee.Ragebot:Lagswitch( CUserCMD )
    if ( not self.Config[ 'hvh_lagswitch' ] or not self.Menu:Keydown( 'hvh_lagswitch_keybind' ) ) then 
        return
    end

    self.isManipulating = true

    local Shift = not CUserCMD:KeyDown( IN_ATTACK ) and not self.Client.Local:IsFlagSet( FL_ONGROUND )

    if ( Shift and CUserCMD:TickCount( ) % self.Config[ 'hvh_lagswitch_hold_time' ] != 0 ) then 
        self.Require:SetOutSequence( self.Require:GetOutSequence( ) - 1 )
    else
        self.Require:SetOutSequence( self.Require:GetOutSequence( ) + ( self.Config[ 'hvh_lagswitch_ticks' ] ) )
    end
end

function Coffee.Ragebot:BreakAnimations( CUserCMD )
    if ( self.Config[ 'hvh_animations' ] ) then 
        if ( self.Config[ 'hvh_animations_break_arms' ] ) then 
            ded.SetTyping( CUserCMD, CUserCMD:TickCount( ) % 4 != 0 )
        end

        if ( self.Config[ 'hvh_animations_spam_act' ] ) then 
            RunConsoleCommand( 'act', 'muscle' )
        end
    end
end