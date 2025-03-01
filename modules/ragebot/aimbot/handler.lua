function Coffee.Ragebot:Aimbot( CUserCMD )
    if ( not self.Config[ 'aimbot_enabled' ] or not self.Menu:Keydown( 'aimbot_enabled_keybind' ) ) then 
        return
    end

    -- Check client information.
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return 
    end

    -- Don't aim if our local player is invalid.
    if ( not self.Client.Local:Alive( ) ) then 
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
    local SWEP = self.Client.Local:GetActiveWeapon( )

    if ( not SWEP ) then 
        return
    end

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
                    Info = Info
                }
            end 
        end
    end

    if ( not Best ) then 
        return
    end
    
    -- Stop moving if needed.
    if ( self.Client.Local:OnGround( ) ) then
        if ( self.Config[ 'aimbot_autostop' ] and self.Menu:Keydown( 'aimbot_autostop_keybind' ) ) then
            CUserCMD:SetForwardMove( 0 )
            CUserCMD:SetSideMove( 0 )
            
            if ( self.Client.Speed > self.Config[ 'aimbot_autostop_speed' ] ) then 
                return
            end
        end
            
        if ( self.Config[ 'aimbot_strip_run' ] ) then 
            CUserCMD:RemoveKey( IN_SPEED )
        end
    end

    -- If we need to manipulate interpolation we can do it here.
    self.Require:SetConVar( 'cl_interpolate', '1' )

    local Delta = self.Records:GetTickDelta( CUserCMD, Best.Record.Simtime )

    if ( Delta > 0.2 ) then 
        local Time = self.Require:Servertime( CUserCMD )

        self.Require:SetConVar( 'cl_interp', tostring( Time - Best.Record.Simtime ) )
        self.Require:SetInterpolation( Time - Best.Record.Simtime )

        self.Require:SetTickCount( CUserCMD, TIME_TO_TICKS( Time ) - 1 )
    else
        self.Require:SetConVar( 'cl_interp', '0' )
        self.Require:SetInterpolation( 0 )

        self.Require:SetTickCount( CUserCMD, TIME_TO_TICKS( Best.Record.Simtime ) )
    end

    -- Get our ideal hitbox.
    local Spot = self.Config[ 'aimbot_invert_hitboxes' ] and Best.Info[ #Best.Info ] or Best.Info[ 1 ]

    -- Set angles.
    self:SetAngles( CUserCMD, ( Spot - self.Client.EyePos ):Angle( ) )

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

    -- Check if we can push a shot.
    if ( CUserCMD:KeyDown( IN_ATTACK ) ) then 
        self.Shots:PushShot( Best.Record )
    end
end