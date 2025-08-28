function Coffee.Ragebot:Aimbot( CUserCMD )
    if ( not Coffee.Config[ 'aimbot_enabled' ] or not self.Menu:Keydown( 'aimbot_enabled_keybind' ) ) then
        return
    end

    -- Check client information.
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return 
    end

    -- Don't aim if we are typing.
    if ( self.Client.Local:IsTyping( ) and not Coffee.Config[ 'hvh_animations_break_arms' ] ) then 
        return
    end

    -- Don't aim in the main menu or console.
    if ( gui.IsConsoleVisible( ) or gui.IsGameUIVisible( ) ) then 
        return 
    end

    -- Don't aim if our local player is invalid.
    if ( not self.Client.Local:Alive( ) ) then 
        return 
    end

    -- Check if we are aiming at a target already.
    if ( Coffee.Config[ 'aimbot_ignore_sticky' ] ) then 
        local Trace = self.Client.Local:GetEyeTrace( )

        local isPlayer = Trace.Entity and Trace.Entity:IsPlayer( )

        if ( Coffee.Config[ 'aimbot_always_sticky' ] ) then
            if ( not isPlayer ) then 
                return 
            end
        elseif ( isPlayer ) then 
            return
        end
    end

    -- Get active SWEP.
    local SWEP = self.Client.Local:GetActiveWeapon( )

    if ( not IsValid( SWEP ) or not SWEP:IsValid( ) ) then 
        return
    end

    -- Get primary fire time and check if we need to add delay.
    local Time = Coffee.Config[ 'aimbot_continuous' ] and CurTime( ) or SWEP:GetNextPrimaryFire( )

    if ( Coffee.Config[ 'aimbot_delay' ] ) then 
        Time = Time + math.Round( Coffee.Config[ 'aimbot_delay_time' ] / 1000, 2 )
    end

    if ( Time >= self.Client.Prediction ) then 
        return 
    end

    -- Check for prediction.
    local usingPrediction = Coffee.Config[ 'aimbot_engine' ] and not Coffee.Config[ 'aimbot_engine_constant' ]

    if ( usingPrediction ) then
        self.Require:StartPrediction( CUserCMD )
    end

    -- Check if we are using optimizations.
    local noIdeal       = self.Optimizations:Valid( 'aimbot_optimizations_ideal_records' )
    local simpleRecords = self.Optimizations:Valid( 'aimbot_optimizations_records' )
    local limitTargets  = self.Optimizations:Valid( 'aimbot_optimizations_targets' )
    local noBones       = self.Optimizations:Valid( 'aimbot_optimizations_hitboxes' )

    -- Check if we are using interpolation.
    local disableInterpolation = Coffee.Config[ 'aimbot_interpolation' ]

    -- Check if we are inversing records.
    local shouldInverse = Coffee.Config[ 'aimbot_inverse' ]

    -- Check if we are using backtrack.
    local usingBacktrack = not disableInterpolation and not noBones and Coffee.Config[ 'aimbot_backtrack' ]

    -- Get targets.
    local Targets = self.Records.Players

    if ( Coffee.Config[ 'aimbot_world_sphere' ] ) then 
        local Hit    = vector_origin

        if ( Coffee.Config[ 'aimbot_obb_range' ] ) then 
            Hit = self.Client.EyePos
        else
            Hit = self.Client.Local:GetEyeTrace( ).HitPos
        end

        local Radius = Coffee.Config[ 'aimbot_world_sphere_fov' ] 
        
        Targets = { }

        for k, Target in pairs( ents.FindInSphere( Hit, Radius ) ) do 
            if ( Target:IsPlayer( ) ) then 
                table.insert( Targets, Target )
            end
        end

        if ( Coffee.Config[ 'aimbot_world_sphere_visualize' ] ) then 
            self.Overlay:Sphere( 
                Hit, 
                Radius, 
                Coffee.Config[ 'aimbot_world_sphere_visualize_step' ], 
                0.05, 
                Coffee.Config[ 'aimbot_world_sphere_visualize_color' ], 
                true 
            )
        end
    end
	
    -- Check if we have limit targets.
    local Limit, Count = Coffee.Config[ 'aimbot_optimizations_targets_amount' ], 0

    -- Get our best records from the valid players.
    local Best;

    for k, Target in pairs( Targets ) do 
        if ( not self:Valid( Target, Best ) ) then 
            continue
        end
                
        local First = usingBacktrack and self.Records:GetFront( Target ) or self.Records:Construct( Target )
        
        if ( First ) then 
            local Info = self:GetHitboxInfo( First )

            if ( Info and self:CheckFOV( Info ) ) then 
                Best = {
                    Record = First,
                    Info = Info
                }
            end 
        end

        if ( usingBacktrack ) then 
            local Last = self.Records:GetLast( Target )

            if ( Last ) then 
                local Info = self:GetHitboxInfo( Last )

                if ( Info and self:CheckFOV( Info ) ) then 
                    Best = {
                        Record = Last,
                        Info = Info
                    }
                end 
            end
        end

        if ( Best ) then 
            Count = Count + 1 

            if ( Count >= Limit ) then
                break
            end
        end
    end
	
    if ( not Best ) then 
        return
    end
    
    -- Stop moving if needed.
    if ( self.Client.Local:OnGround( ) ) then
        if ( Coffee.Config[ 'aimbot_autostop' ] and self.Menu:Keydown( 'aimbot_autostop_keybind' ) ) then
            CUserCMD:SetForwardMove( 0 )
            CUserCMD:SetSideMove( 0 )
            
            if ( self.Client.Speed > Coffee.Config[ 'aimbot_autostop_speed' ] ) then 
                return
            end
        end
            
        if ( Coffee.Config[ 'aimbot_strip_run' ] ) then 
            CUserCMD:RemoveKey( IN_SPEED )
        end
    end

    -- If we need to manipulate interpolation we can do it here.
    self.Require:SetConVar( 'cl_interpolate', disableInterpolation and '0' or '1' )

    if ( not disableInterpolation ) then 
        local Extended = self.Records:GetTickDelta( Best.Record.Simtime ) > 0.2

        if ( Coffee.Config[ 'aimbot_extended' ] and Extended ) then 
            local Time = self.Require:Servertime( CUserCMD )

            self.Require:SetConVar( 'cl_interp', tostring( Time - Best.Record.Simtime ) )
            self.Require:SetInterpolation( Time - Best.Record.Simtime )

            self.Require:SetTickCount( CUserCMD, TIME_TO_TICKS( Time ) - 1 )
        else
            self.Require:SetConVar( 'cl_interp', '0' )
            self.Require:SetInterpolation( 0 )

            self.Require:SetTickCount( CUserCMD, TIME_TO_TICKS( Best.Record.Simtime ) )
        end
    end
    
    -- Get our hitbox information.
    local Info = Coffee.Config[ 'aimbot_invert_hitboxes' ] and Best.Info[ #Best.Info ] or Best.Info[ 1 ]

    -- Get our ideal hitbox.
    local Spot = Info.Hitbox

    Spot:Sub( self.Client.Local:GetShootPos( ) )
    Spot:Normalize( )

    -- Set angles.
    local Angles = self:CalculateCompensation( 
        CUserCMD, 
        Spot, 
        Coffee.Config[ 'aimbot_norecoil' ], 
        Coffee.Config[ 'aimbot_nospread' ] 
    )
	
	if ( self.Config[ 'aimbot_normalize' ] ) then
		Angles:Normalize()
		
		Angles.x = ( ( Angles.x + 180 ) % 360 ) - 180
		Angles.x = math.Clamp( Angles.x, -89, 89 )
		Angles.y = ( ( Angles.y + 180 ) % 360 ) - 180
		Angles.y = math.Clamp( Angles.y, -180, 180 )
		Angles.z = 0
	end
    
    self:SetAngles( CUserCMD, Angles )

    -- Shoot if needed.
    if ( Coffee.Config[ 'aimbot_autofire' ] ) then 
        local Mode = Coffee.Config[ 'aimbot_autofire_mode' ]

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
    Best.Record.Group = Info.Group

    if ( CUserCMD:KeyDown( IN_ATTACK ) ) then 
        self.Shots:PushShot( Best.Record )
    end

    if ( usingPrediction ) then
        self.Require:EndPrediction( CUserCMD )
    end
    
    self.currentAngle = Angles
end