Coffee.Shots = { 
    Client = Coffee.Client,
    Config = Coffee.Config,
    Hooks  = Coffee.Hooks,

    Cache = { }
}

function Coffee.Shots:OnMissedShot( wasResolver, Record )
    if ( wasResolver ) then
        if ( self.Config[ 'aimbot_log_desync' ] ) then
            if ( Record.Fake ) then 
                Coffee:Print( false, 'Missed shot due to fake angles.' )
            else
                Coffee:Print( false, 'Missed shot due to animation desync.' )
            end
        end
    elseif ( self.Config[ 'aimbot_log_spread' ] ) then
        Coffee:Print( false, 'Missed shot due to spread.' ) 
    end

    self.Hooks:Call( 'Missed', wasResolver, Record )
end

function Coffee.Shots:PushShot( Record, Time )
    if ( not Record or not Record.Target ) then 
        return
    end

    Time = Time or self.Client.Tickbase

    table.insert( self.Cache, 1, {
        Time      = Time,
        Record    = Record,

        Spread    = false,
        Processed = false,
        Landed    = false
    } )

    while ( #self.Cache > 32 ) do 
        table.remove( self.Cache )
    end
end

function Coffee.Shots:Landed( Data )
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return
    end

    local Inflictor = Player( Data.attacker )

    if ( not Inflictor or Inflictor != self.Client.Local ) then 
        return
    end
    
    local Hit = Player( Data.userid )

    for k, Slot in pairs( self.Cache ) do 
        if ( Slot.Landed ) then 
            continue
        end

        if ( Slot.Record.Target != Hit ) then 
            continue
        end

        Slot.Landed = true 
    end
end

function Coffee.Shots:Processed( ENT, Data )
    if ( ENT != self.Client.Local ) then 
        return
    end
    
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return
    end

    for k, Slot in pairs( self.Cache ) do 
        if ( Slot.Processed ) then 
            continue
        end

        -- Run a trace and see if it was a miss because of spread.
        -- For some reason I couldn't get TraceLine's to work properly in here no matter
        -- what mask I used. So for now this is the dirty fix.
        local Trace = ents.FindAlongRay(
            Data.Trace.StartPos,
            Data.Trace.HitPos
        )
        
        Slot.Spread = true
        
        for i = 1, #Trace do
            if ( Trace[ i ] == Slot.Record.Target ) then 
                Slot.Spread = false 
                break
            end
        end

        -- We finished processing.
        Slot.Processed = true
        
        break
    end
end

function Coffee.Shots:Finish( )
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return
    end

    local Invalid = { }

    -- This is a ghetto fix to an issue I was having at high ping where the playerhurt event was 
    -- way too delayed.
    local Timeslot = ( self.Client.Ping / 6 )

    for k, Slot in pairs( self.Cache ) do 
        if ( not Slot.Processed ) then 
            continue
        end
        
        if ( self.Client.Tickbase - Slot.Time >= Timeslot ) then
            table.insert( Invalid, k )

            if ( not Slot.Landed ) then 
                self:OnMissedShot( not Slot.Spread, Slot.Record )
            end
        end
    end

    for i = 1, #Invalid do 
        table.remove( self.Cache, Invalid[ i ] )
    end

    while ( #self.Cache > 32 ) do 
        table.remove( self.Cache )
    end
end

gameevent.Listen( 'player_hurt' )

Coffee.Hooks:New( 'player_hurt', Coffee.Shots.Landed, Coffee.Shots )
Coffee.Hooks:New( 'PostEntityFireBullets', Coffee.Shots.Processed, Coffee.Shots )
Coffee.Hooks:New( 'Tick', Coffee.Shots.Finish, Coffee.Shots )