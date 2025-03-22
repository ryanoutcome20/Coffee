Coffee.Visuals.Icons = {
    Ammo = {
        [ 'Pistol' ]                = 'd',
        [ '357' ]                   = 'd',
        [ 'SMG1' ]                  = 'a',
        [ 'AR2' ]                   = 'l',
        [ 'SniperPenetratedRound' ] = 'f',
        [ 'Buckshot' ]              = 'b',
        [ 'Grenade' ]               = 'k',
        [ 'RPG_Round' ]             = 'i',
        [ 'XBowBolt' ]              = 'g'
    },

    Classes = {
        [ 'weapon_physgun' ]    = 'h',
        [ 'weapon_physcannon' ] = 'm',
        [ 'weapon_crowbar' ]    = 'c'
    }
}

function Coffee.Visuals.Icons:Get( SWEP, Class )
    local Ammo = self.Ammo[ game.GetAmmoName( SWEP:GetPrimaryAmmoType( ) ) ]
    
    if ( Ammo ) then 
        return Ammo
    end

    return self.Classes[ Class or SWEP:GetClass( ) ]
end