function Coffee.Ragebot:GetHitboxConditions( Record, Group )
    if ( Group > HITGROUP_STOMACH ) then 
        if ( self.Config[ 'aimbot_ignore_moving_limbs' ] and Record.Speed > 0 ) then 
            return false 
        end
    end

    if ( Group == HITGROUP_HEAD ) then 
        if ( self.Config[ 'aimbot_ignore_airbourne_head' ] and Record.Player and not Record.Target:OnGround( ) ) then 
            return false
        end
    end

    return true 
end

function Coffee.Ragebot:GetHitboxInfo( Record )
    local Info = { }

    if ( not istable( Record.Bones ) ) then 
        return 
    end

    local Autowall = self.Config[ 'aimbot_autowall' ]
    local Damage   = self.Config[ 'aimbot_autowall_damage' ]

    for i = 0, HITGROUP_RIGHTLEG do 
        local Data, Group = Record.Bones[ i ], self.Hitboxes[ i ]

        if ( not Data or not Group or not self.Config[ Group ] ) then 
            continue
        end

        if ( not self:GetHitboxConditions( Record, i ) ) then 
            continue
        end

        if ( not istable( Data ) ) then 
            continue
        end 

        for i = 1, #Data do 
            if ( not self:RunTrace( Record, Data[ i ], Autowall, Damage ) ) then 
                continue
            end

            table.insert( Info, Data[ i ] )
        end
    end

    if ( #Info == 0 ) then 
        return
    end 

    return Info
end