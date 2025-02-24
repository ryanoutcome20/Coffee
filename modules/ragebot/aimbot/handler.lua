function Coffee.Ragebot:Aimbot( CUserCMD )
    if ( not self.Config[ 'aimbot_enabled' ] or not self.Menu:Keydown( 'aimbot_enabled_keybind' ) ) then 
        return
    end

    -- Check client information.
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return 
    end

    -- Don't aim if our local player is invalid.
    if ( not self.Client.Alive ) then 
        return 
    end

    -- Check if we are aiming at a target already.
    if ( self.Config[ 'aimbot_ignore_sticky' ] ) then 
        local Trace = self.Client.Local:GetEyeTrace( )

        if ( Trace.Entity and Trace.Entity:IsPlayer( ) ) then 
            return 
        end
    end

    -- Get active SWEP.
    local SWEP = self.Client.Weapon

    -- Get primary fire time and check if we need to add delay.
    local Time = SWEP:GetNextPrimaryFire( )

    if ( self.Config[ 'aimbot_delay' ] ) then 
        Time = Time + math.Round( self.Config[ 'aimbot_delay_time' ] / 1000, 2 )
    end

    if ( Time >= self.Client.Prediction ) then 
        return 
    end

    -- Check if we are using backtrack.
    local usingBacktrack = self.Config[ 'aimbot_backtrack' ]

    -- Get our best records from the valid players.
    local Best;

    for k, Target in pairs( self.Records.Players ) do 
        if ( not self:Valid( Target, Best ) ) then 
            continue
        end

        if ( usingBacktrack ) then 
            local Ideal = self.Records:GetIdeal( CUserCMD, Target, self.Config[ 'aimbot_inverse' ] )

            if ( Ideal and self.Records:Valid( CUserCMD, Ideal ) ) then 
                local Info = self:GetHitboxInfo( Ideal )

                if ( Info ) then 
                    Best = {
                        Record = Ideal,
                        Backtrack = true,
                        Info = Info
                    }
                end 
            end
        end

        local First = usingBacktrack and self.Records:GetFront( Target ) or self.Records:Construct( Target )
        
        if ( First and self.Records:Valid( CUserCMD, First ) ) then 
            local Info = self:GetHitboxInfo( First )

            if ( Info ) then 
                Best = {
                    Record = First,
                    Backtrack = false,
                    Info = Info
                }
            end 
        end
    end

    if ( not Best ) then 
        return
    end

    -- If we need to manipulate interpolation we can do it here.
    ded.NetSetConVar( 'cl_interpolate', '1' )

    local Delta = self.Records:GetTickDelta( CUserCMD, Best.Record.Simtime )

    if ( Delta > 0.2 ) then 
        local Time = ded.GetServerTime( CUserCMD )

        ded.NetSetConVar( 'cl_interp', tostring( Time - Best.Record.Simtime ) )
        ded.SetInterpolationAmount( Time - Best.Record.Simtime )

        ded.SetCommandTick( CUserCMD, TIME_TO_TICKS( Time ) - 1 )
    else
        ded.NetSetConVar( 'cl_interp', '0' )
        ded.SetInterpolationAmount( 0 )

        ded.SetCommandTick( CUserCMD, TIME_TO_TICKS( Best.Record.Simtime ) )
    end

    -- Get our ideal hitbox.
    local Spot = self.Config[ 'aimbot_invert_hitboxes' ] and Best.Info[ #Best.Info ] or Best.Info[ 1 ]

    -- Set angles.
    self:SetAngles( CUserCMD, ( Spot - self.Client.EyePos ):Angle( ) )

    -- Stop moving if needed.
    if ( self.Config[ 'aimbot_autostop' ] ) then 
        CUserCMD:SetForwardMove( 0 )
        CUserCMD:SetSideMove( 0 )
    end

    -- Shoot if needed.
    if ( self.Config[ 'aimbot_autofire' ] ) then 
        local Mode = self.Config[ 'aimbot_autofire_mode' ]

        if ( Mode == 'Left' ) then 
            CUserCMD:AddKey( IN_ATTACK )
        elseif ( Mode == 'Right' ) then 
            CUserCMD:AddKey( IN_ATTACK2 )
        else
            CUserCMD:AddKey( IN_ATTACK )
            CUserCMD:AddKey( IN_ATTACK2 )
        end
    end
end