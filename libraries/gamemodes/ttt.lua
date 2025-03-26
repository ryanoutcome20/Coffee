function Coffee.Gamemodes:CheckWeapons( ENT, Role )
    local SWEPs = ENT:GetWeapons( )

    for k, SWEP in ipairs( SWEPs ) do
        if ( not SWEP or not SWEP:IsValid( ) ) then 
            continue
        end
        
        local Class = SWEP:GetClass( )

        if ( self.Cache[ Class ] == Role ) then 
            return true
        end

        local Data = weapons.GetStored( Class )
    
        if ( Data and Data.CanBuy ) then 
            for k, Index in ipairs( Data.CanBuy ) do 
                if ( Index == Role ) then 
                    self.Cache[ Class ] = Role
                    return true
                end
            end
        end
    end

    return false
end

function Coffee.Gamemodes:IsDetective( ENT, Advanced )
    if ( ENT.IsDetective and ENT:IsDetective( ) ) then 
        return true
    end

    if ( ENT.IsActiveDetective and ENT:IsActiveDetective( ) ) then 
        return true
    end

    if ( Advanced ) then 
        return self:CheckWeapons( ENT, ROLE_DETECTIVE )
    end

    return false
end

function Coffee.Gamemodes:IsTraitor( ENT )
    if ( ENT.IsTraitor and ENT:IsTraitor( ) ) then 
        return true
    end

    if ( ENT.IsActiveTraitor and ENT:IsActiveTraitor( ) ) then 
        return true
    end

    return self:CheckWeapons( ENT, ROLE_TRAITOR )
end