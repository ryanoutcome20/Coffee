Coffee.Bots.Otherbot = { 
    Gamemode = Coffee.Gamemode,
    Config   = Coffee.Config,
    Client   = Coffee.Client,
    Menu     = Coffee.Menu,

    Cover    = false
}

function Coffee.Bots.Otherbot:Equipbot( CUserCMD )
    if ( not self.Config[ 'miscellaneous_equipbot' ] ) then 
        return
    end

    if ( not self.Config[ 'miscellaneous_equipbot_ignore_gamemode' ] and self.Gamemode != 'sandbox' ) then 
        return
    end

    local Item = self.Config[ 'miscellaneous_equipbot_item' ]

    -- Check if we need to force equip the item.
    local ENT = self.Client.Local:GetWeapon( Item )

    if ( ENT == NULL ) then 
        -- I would love to use Player:Give here but its serverside only.
        RunConsoleCommand( 'gm_giveswep', Item )
        return
    end

    -- Select our entity.
    if ( self.Config[ 'miscellaneous_equipbot_auto_select' ] ) then 
        input.SelectWeapon( ENT )
    end
end

function Coffee.Bots.Otherbot:Coverbot( CUserCMD )
    if ( not self.Config[ 'miscellaneous_coverbot' ] or not self.Menu:Keydown( 'miscellaneous_coverbot_keybind' ) ) then 
        self.Cover = false
        return
    end

    if ( self.Cover ) then 
        return
    end

    local Prop = self.Config[ 'miscellaneous_coverbot_prop' ]

    if ( Prop ) then 
        CUserCMD:SetViewAngles( Angle( 89, 0, 0 ) )

        RunConsoleCommand( 'gm_spawn', Prop )

        self.Cover = true
    end
end

function Coffee.Bots.Otherbot:Handler( CUserCMD )
    self:Coverbot( CUserCMD )
    self:Equipbot( CUserCMD )
end