Coffee.Announcer = { 
    Client = Coffee.Client,
    Config = Coffee.Config,

    Kills = 0
}

function Coffee.Announcer:Play( Name )
    local Directory = self.Config[ 'world_announcer_directory' ] .. '/' .. Name .. '.wav'

    if ( not file.Exists( 'sound/' .. Directory, 'GAME' ) ) then 
        return
    end

    self.Client.Local:EmitSound( 
        Directory, 
        511,
        100,
        self.Config[ 'world_announcer_volume' ] / 100,
        CHAN_STATIC,
        0
    )
end

function Coffee.Announcer:Start( Data )
    if ( not self.Config[ 'world_announcer' ] ) then 
        return
    end
    
    local ENT = Player( Data.userid )

    if ( not IsValid( ENT ) or ENT != self.Client.Local ) then 
        return
    end

    self:Play( 'spawn' )
end

function Coffee.Announcer:Kill( Data )
    if ( not self.Config[ 'world_announcer' ] ) then 
        return
    end

    local Victim    = Entity( Data.entindex_killed )
    local Inflictor = Entity( Data.entindex_attacker ) 

    if ( not IsValid( Victim ) or not IsValid( Inflictor ) ) then 
        return
    end

    if ( Victim != self.Client.Local and Inflictor == self.Client.Local ) then 
        self.Kills = self.Kills + 1

        if ( self.Config[ 'world_announcer_killstreak' ] and self.Kills % self.Config[ 'world_announcer_killstreak_number' ] == 0 ) then 
            self:Play( 'killstreak' )
        elseif ( self.Config[ 'world_announcer_kill' ] and math.random( ) <= self.Config[ 'world_announcer_kill_chance' ] / 100 ) then
            self:Play( 'kill' )
        end
    elseif ( Victim == self.Client.Local and Inflictor != self.Client.Local ) then
        self:Play( 'death' )
    end
end

gameevent.Listen( 'entity_killed' )
gameevent.Listen( 'player_spawn' )

Coffee.Hooks:New( 'entity_killed', Coffee.Announcer.Kill, Coffee.Announcer )
Coffee.Hooks:New( 'player_spawn', Coffee.Announcer.Start, Coffee.Announcer )