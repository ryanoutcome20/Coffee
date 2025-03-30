Coffee.Notify = { 
    Client = Coffee.Client,
    Config = Coffee.Config,

    Cache = { }
}

function Coffee.Notify:Add( Text, Decay )
    while ( #self.Cache > 10 ) do 
        table.remove( self.Cache, 1 )
    end 

    table.insert( self.Cache, {
        Text  = Text,
        Decay = Decay or 3,
        Time  = CurTime( )
    } )

    if ( self.Config[ 'miscellaneous_notifications_hints' ] ) then 
        notification.AddLegacy( Text, self.Config[ 'miscellaneous_notifications_hints_type' ], 2 )

        if ( self.Config[ 'miscellaneous_notifications_hints_noise' ] ) then 
            surface.PlaySound( 'buttons/button15.wav' )
        end
    end

    if ( self.Config[ 'miscellaneous_notifications_console' ] ) then 
        Coffee:Print( false, Text )
    end
end

function Coffee.Notify:Hurt( Data )
    local Victim = Player( Data.userid )
    local Inflictor = Player( Data.attacker )

    if ( not IsValid( Victim ) or not IsValid( Inflictor ) ) then 
        return
    end

    local Damage = Victim:Health( ) - Data.health
        
    if ( Victim == Inflictor ) then 
        return
    end

    if ( Victim == self.Client.Local and self.Config[ 'miscellaneous_notifications_incoming' ] ) then 
        local Name = Inflictor == NULL and 'unknown' or Inflictor:Name( ) 

        if ( Data.health > 0 ) then 
            self:Add( string.format( 'Hurt by %s for %s (%s health remaining).', Name, Damage, Data.health ) )
        else
            self:Add( string.format( 'Killed by %s.', Name ) )
        end
    elseif ( Inflictor == self.Client.Local and self.Config[ 'miscellaneous_notifications_outgoing' ] ) then
        local Name = Victim == NULL and 'unknown' or Victim:Name( ) 

        if ( Data.health > 0 ) then 
            self:Add( string.format( 'Hurt %s for %s (%s health remaining).', Name, Damage, Data.health ) )
        else
            self:Add( string.format( 'Killed %s.', Name ) )
        end    
    end
end

function Coffee.Notify:Connect( Data )
    if ( self.Config[ 'miscellaneous_notifications_join' ] ) then 
        self:Add( string.format( '%s joined the session.', Data.name ) )
    end
end

function Coffee.Notify:Disconnect( Data )
    if ( self.Config[ 'miscellaneous_notifications_leave' ] ) then 
        self:Add( string.format( '%s left the session.', Data.name ) )
    end
end

gameevent.Listen( 'player_connect_client' )
gameevent.Listen( 'player_disconnect' )
gameevent.Listen( 'player_hurt' )

Coffee.Hooks:New( 'player_connect_client', Coffee.Notify.Connect, Coffee.Notify )
Coffee.Hooks:New( 'player_disconnect', Coffee.Notify.Disconnect, Coffee.Notify )
Coffee.Hooks:New( 'player_hurt', Coffee.Notify.Hurt, Coffee.Notify )