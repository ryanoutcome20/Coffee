Coffee.Ragebot.Packs = {
    [ 'weapon_swcs_base' ] = Coffee.Ragebot.SWCS
}

function Coffee.Ragebot:SetPack( SWEP )
    local Pack = self.Packs[ SWEP.Base ] or self.HL2

    table.Merge( self, Pack, true )
end