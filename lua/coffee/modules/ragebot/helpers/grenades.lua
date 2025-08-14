function Coffee.Ragebot:AdjustGrenades( CUserCMD )
    if ( not Coffee.Config[ 'aimbot_grenade' ] or not self.Menu:Keydown( 'aimbot_grenade_keybind' ) ) then 
        return
    end

    -- For some reason, SWCS grenades like to lag a lot ahead of your real view angles, 
    -- and that can cause them to go way off course; this should be a nice fix for that.

    local Distance = -Coffee.Config[ 'aimbot_grenade_distance' ] / 1000
    local Velocity = self.Client.Local:GetVelocity( ):Dot( self.Client.Local:GetRight( ) )

    local Angles = CUserCMD:GetViewAngles( )
    Angles.y = Angles.y - ( Velocity * Distance )

    CUserCMD:SetViewAngles( Angles )
end