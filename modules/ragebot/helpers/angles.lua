function Coffee.Ragebot:SetupMovement( CUserCMD )
    local Move = Vector( CUserCMD:GetForwardMove(), CUserCMD:GetSideMove(), 0 )

    local Speed = Move:Length2D()

    local View = CUserCMD:GetViewAngles()
    View:Normalize()
    
    local Yaw = math.deg( math.atan2( Move.y, Move.x ) )
    Yaw = math.rad( View.y - self.Silent.y + Yaw )

    -- Setup movement to predicted values.
    CUserCMD:SetForwardMove( math.cos( Yaw ) * Speed )
    CUserCMD:SetSideMove( math.sin( Yaw ) * Speed )

    -- Fix weird movement bug when using invalid angles.
    if math.abs( View.x ) > 90 then
        CUserCMD:SetForwardMove( -CUserCMD:GetForwardMove( ) )
        CUserCMD:SetSideMove( -CUserCMD:GetSideMove( ) )
    end
end

function Coffee.Ragebot:SetAngles( CUserCMD, Target )
    local Mode = self.Config[ 'aimbot_silent_mode' ]
    
    if ( Mode == 'Serverside' ) then 
        ded.SetContextVector( CUserCMD, Target:Forward( ), true )
    else
        if ( self.Config[ 'aimbot_silent_hide' ] ) then 
            Target.y = Target.y + 720
        end

        CUserCMD:SetViewAngles( Target )
    end
end