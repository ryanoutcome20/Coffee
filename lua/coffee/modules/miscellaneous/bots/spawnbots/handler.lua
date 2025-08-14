Coffee.Bots.Spawnbot = {     
    Config   = Coffee.Config,
    Client   = Coffee.Client,

    Active   = false
}

function Coffee.Bots.Spawnbot:SpawnShield( CUserCMD )
    if ( not Coffee.Config[ 'miscellaneous_spawnshield' ] ) then 
        return
    end

    local Prop = Coffee.Config[ 'miscellaneous_spawnshield_prop' ]

    if ( Prop ) then 
        CUserCMD:SetViewAngles( Angle( 89, 0, 0 ) )

        RunConsoleCommand( 'gm_spawn', Prop )
    end
end

function Coffee.Bots.Spawnbot:Handler( CUserCMD )
    if ( not self.Active ) then 
        return
    end

    self.Active = false
    
    self:SpawnShield( CUserCMD )
end

function Coffee.Bots.Spawnbot:Activate( Data )
    local ENT = Player( Data.userid )

    if ( not IsValid( ENT ) or ENT != self.Client.Local ) then 
        return
    end

    self.Active = true
end

gameevent.Listen( 'player_spawn' )

Coffee.Hooks:New( 'player_spawn', Coffee.Bots.Spawnbot.Activate, Coffee.Bots.Spawnbot )