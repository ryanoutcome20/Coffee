function Coffee.Ragebot:Valid( Target, Best )
    if ( Best and Best.Record.Health < Target:Health( ) ) then 
        return false
    end

    if ( self.Client.Local == Target or Target:IsDormant( ) or not Target:Alive( ) or Target:Health( ) <= 0 ) then 
        return false
    end

    if ( self.Config[ 'aimbot_avoid_teammates' ] and Target:Team( ) == self.Client.Team ) then 
        return false
    end

    if ( self.Config[ 'aimbot_avoid_buildmode' ] ) then 
        if ( Target.buildmode ) then 
            return false 
        end

        if ( Target:GetNWBool( 'BuildMode' ) ) then 
            return false 
        end
    end

    if ( self.Config[ 'aimbot_avoid_steam_friends' ] and Target:GetFriendStatus( ) == 'friend' ) then 
        return false
    end

    if ( self.Config[ 'aimbot_avoid_noclip' ] and Target:GetMoveType( ) == MOVETYPE_NOCLIP ) then 
        return false
    end

    if ( self.Config[ 'aimbot_avoid_vehicles' ] and Target:InVehicle( ) ) then 
        return false
    end
    
    if ( self.Config[ 'aimbot_avoid_invisible' ] and Target:GetColor( ).a == 0 ) then 
        return false
    end

    if ( self.Config[ 'aimbot_avoid_bots' ] and Target:IsBot( ) ) then 
        return false
    end

    return true 
end