function Coffee.Ragebot:SetupMovement( CUserCMD )
    local View = CUserCMD:GetViewAngles( )
    local Invert = -1

    if ( math.abs( View.x ) > 89 ) then 
        Invert = 1
    end
    
	local Delta = math.rad( math.NormalizeAngle( ( View.y - self.Silent.y ) * Invert ) )

    local newForward = CUserCMD:GetForwardMove( ) * -math.cos( Delta ) * Invert + CUserCMD:GetSideMove( ) * math.sin( Delta )
	local newSide    = CUserCMD:GetForwardMove( ) * math.sin( Delta ) * Invert + CUserCMD:GetSideMove( ) * math.cos( Delta )

	newForward = ClampMovement( newForward )
	newSide = ClampMovement( newSide )

	CUserCMD:SetForwardMove( newForward )
	CUserCMD:SetSideMove( newSide )
end

function Coffee.Ragebot:SetAngles( CUserCMD, Target )
    local Mode = Coffee.Config[ 'aimbot_silent_mode' ]
	    
    if ( Mode == 'Serverside' ) then 
        self.Require:SetContextVector( CUserCMD, angle_zero )
    else
        if ( Coffee.Config[ 'aimbot_silent_hide' ] ) then 
            Target.y = Target.y + 720
        end

        CUserCMD:SetViewAngles( Target )
		
		if ( Coffee.Config[ 'aimbot_mouse_emulator' ] ) then
			CUserCMD:SetMouseX( Target.x )
			CUserCMD:SetMouseY( Target.y )
		end
    end
end