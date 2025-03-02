function Coffee.Ragebot:ShouldSilent( )
    if ( self.Config[ 'aimbot_silent' ] and self.Config[ 'aimbot_silent_mode' ] == 'Clientside' ) then 
        return true 
    end
    
    return false
end

function Coffee.Ragebot:SetupSilent( CUserCMD )
    if ( not self:ShouldSilent( ) ) then 
        self.Silent = CUserCMD:GetViewAngles( )
        return
    end
    
    if ( CUserCMD:CommandNumber( ) == 0 ) then 
        CUserCMD:SetViewAngles( self.Silent )
    end

    local Yaw = self.Yaw:GetFloat( )
    local Pitch = self.Pitch:GetFloat( )

    self.Silent = self.Silent + Angle( CUserCMD:GetMouseY( ) * Pitch, CUserCMD:GetMouseX() * -Yaw, 0 )
    self.Silent.x = math.Clamp( self.Silent.x, -89, 89 )
    self.Silent.z = 0

    self.Silent:Normalize( )
end