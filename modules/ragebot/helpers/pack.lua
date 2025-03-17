Coffee.Ragebot.Packs = {
    [ 'weapon_swcs_base' ] = Coffee.Ragebot.SWCS,

    [ 'tfa_gun_base' ]        = Coffee.Ragebot.TFA,
    [ 'tfa_csgo_base' ]       = Coffee.Ragebot.TFA,
    [ 'tfa_cso_crow_base' ]   = Coffee.Ragebot.TFA,
    [ 'tfa_3dscoped_base' ]   = Coffee.Ragebot.TFA,
    [ 'tfa_bash_base' ]       = Coffee.Ragebot.TFA,
    [ 'tfa_rust_recoilbase' ] = Coffee.Ragebot.TFA,

    [ 'bobs_gun_base' ]    = Coffee.Ragebot.M9K,
    [ 'bobs_scoped_base' ] = Coffee.Ragebot.M9K,
    [ 'bobs_shotty_base' ] = Coffee.Ragebot.M9K,
    [ 'bobs_blacklisted' ] = Coffee.Ragebot.M9K
}

function Coffee.Ragebot:SetPack( SWEP )
    local Pack = self.Packs[ SWEP.Base ] or self.HL2

    table.Merge( self, Pack, true )
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