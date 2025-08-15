function Coffee.Ragebot:CheckFOV( Hitboxes )
	if ( not Coffee.Config[ 'aimbot_fov' ] ) then
		return true
	end
	
	local Amount = Coffee.Config[ 'aimbot_fov_amount' ]
	
	for k, Object in ipairs( Hitboxes ) do	
		local Delta = Object.Hitbox - self.Client.EyePos

		Delta:Normalize()

		Delta = math.deg(math.acos(self.Silent:Forward():Dot(Delta)))

		if math.abs(Delta) <= Amount then
			return true
		end
	end
	
	return false
end

function Coffee.Ragebot:CheckValid( Target, Best )
    local Team = Target:Team( )

    if ( Coffee.Config[ 'aimbot_avoid_teammates' ] and Team == self.Client.Team ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_buildmode' ] ) then 
        if ( Target.buildmode ) then 
            return false 
        end

        if ( Target:GetNWBool( 'BuildMode' ) ) then 
            return false 
        end
		
		if ( Target:GetNWBool( '_Kyle_Buildmode' ) ) then
			return false
		end
    end

    if ( Coffee.Config[ 'aimbot_avoid_spawn_protection'] ) then
        if ( Target:GetNW2Bool( 'LibbyProtectedSpawn' ) ) then
            return false
        end
    end

    if ( Coffee.Config[ 'aimbot_avoid_steam_friends' ] and Target:GetFriendStatus( ) == 'friend' ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_noclip' ] and Target:GetMoveType( ) == MOVETYPE_NOCLIP ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_vehicles' ] and Target:InVehicle( ) ) then 
        return false
    end
    
    if ( Coffee.Config[ 'aimbot_avoid_invisible' ] and Target:GetColor( ).a == 0 ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_bots' ] and Target:IsBot( ) ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_hunters' ] and TEAM_HUNTERS != nil and Team == TEAM_HUNTERS ) then 
        return false
    end
    
    if ( Coffee.Config[ 'aimbot_avoid_props' ] and TEAM_PROPS != nil and Team == TEAM_PROPS ) then 
        return false
    end

    if ( Coffee.Config[ 'aimbot_avoid_deathmatch' ] and Target.InDM and Target:InDM( ) ) then 
        return false
    end

    return true 
end

function Coffee.Ragebot:Valid( Target, Best )
    if ( Best and Best.Record.Health < Target:Health( ) ) then 
        return false
    end

    if ( self.Client.Local == Target or Target:IsDormant( ) or not Target:Alive( ) or Target:Health( ) <= 0 ) then 
        return false
    end

    if ( Target.HasGodMode and Target:HasGodMode( ) ) then 
        return false
    end

    local Valid = self:CheckValid( Target, Best )

    if ( Coffee.Config[ 'aimbot_avoid_invert' ] ) then 
        Valid = not Valid
    end

    return Valid
end