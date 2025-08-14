Coffee.Ragebot.Packs = {
    [ 'bobs_gun_base' ]    = Coffee.Ragebot.M9K,
    [ 'bobs_scoped_base' ] = Coffee.Ragebot.M9K,
    [ 'bobs_shotty_base' ] = Coffee.Ragebot.M9K,
    [ 'bobs_blacklisted' ] = Coffee.Ragebot.M9K,

    [ 'unclen8_scoped_base' ] = Coffee.Ragebot.M9K,
    [ 'unclen8_gun_base' ]    = Coffee.Ragebot.M9K
}

function Coffee.Ragebot:SetPack( SWEP )
    local Pack = self.Packs[ SWEP.Base ] or self.HL2

    table.Merge( self, Pack, true )
end

function Coffee.Ragebot:GetWeaponDamageScale( Damage, ID, Group )
    if ( not ID or not Group or game.GetAmmoDamageType( ID ) != DMG_BULLET ) then 
        return Damage
    end

    -- This is weird and isn't accurate but I have no idea what they're doing.
    -- The builtin sk commands aren't functional and are inaccurate anyways.
    -- The damage scales strange (8 dmg turns to 2 in feet but 4 turns to 3). 

    if ( Group == HITGROUP_HEAD	) then 
        Damage = Damage * 8
    elseif ( Group == HITGROUP_CHEST or Group == HITGROUP_STOMACH ) then
        Damage = Damage * 4
    end
    
    return Damage
end

function Coffee.Ragebot:GetWeaponDamage( Weapon, Group )
    if ( not Coffee.Config[ 'aimbot_minimum_damage' ] ) then 
        return math.huge
    end

    local ID = Weapon:GetPrimaryAmmoType( )

    return game.GetAmmoPlayerDamage( ID ) - 1, ID
end

function Coffee.Ragebot:PenetrateEntities( Trace, Record )
    if ( Trace.HitWorld ) then 
        return
    end
    
    if ( not IsValid( Trace.Entity ) or Trace.Entity:Health( ) == 0 ) then 
        return
    end

    if ( Trace.Entity:GetMaxHealth( ) > ( 100 - Coffee.Config[ 'aimbot_engine_entity_damage' ] ) + 1 ) then 
        return
    end

    local Secondary = util.TraceLine( { 
        start = Trace.HitPos, 
        endpos = Matrix, 
        filter = { self.Client.Local, Record.Target, Trace.Entity }, 
        mask = MASK_SHOT 
    } )

    return Secondary.Fraction == 1
end

function Coffee.Ragebot:SetupCone( ENT, Bullet )
    if ( not ENT or ENT != self.Client.Local ) then 
        return
    end

    local SWEP = ENT:GetActiveWeapon( )

    if ( not SWEP or not SWEP:IsValid( ) ) then 
        return
    end

    local Name = SWEP:GetPrintName( )

    if ( not self.Cones[ Name ] or SWEP:IsScripted( ) or self.Cones[ Name ] != Bullet.Spread ) then 
        self.Cones[ Name ] = Bullet.Spread
    end
end

Coffee.Hooks:New( 'EntityFireBullets', Coffee.Ragebot.SetupCone, Coffee.Ragebot )