Coffee.Shots = { 
    Client    = Coffee.Client,
    Notify    = Coffee.Notify,
    Config    = Coffee.Config,
    Hooks     = Coffee.Hooks,
    Require   = Coffee.Require,
    Overlay   = Coffee.Overlay,
    Hitboxes  = Coffee.Hitboxes,
    Hitmarker = Coffee.Hitmarker,

    Cache = { }
}

function Coffee.Shots:OnMissedShot( wasResolver, Record )
    if ( wasResolver ) then
        if ( self.Config[ 'aimbot_log_desync' ] ) then
            if ( Record.Fake ) then 
                self.Notify:Add( 'Missed shot due to fake angles.' )
            else
                self.Notify:Add( 'Missed shot due to animation desync.' )
            end
        end
    elseif ( self.Config[ 'aimbot_log_spread' ] ) then
        self.Notify:Add( 'Missed shot due to spread.' ) 
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

    self.Cache = self:Clean( self.Cache, Time )
end

function Coffee.Shots:Clean( Cache, Time )
    local Rebuilt = table.Copy( Cache )

    -- Usually it'll never register because the server
    -- fails to receive it.
    for k, Slot in pairs( Cache ) do 
        if ( Slot.Time + 1 < Time ) then 
            table.remove( Rebuilt, k )
        end
    end

    return Rebuilt
end

function Coffee.Shots:PushMatrix( Record )
    if ( not Record.Group or not self.Config[ 'aimbot_shot_matrix' ] ) then 
        return
    end

    local Group = self.Config[ 'aimbot_shot_matrix_singular' ] and Record.Group

    -- This won't align with backtrack but since its a rarely used feature they
    -- don't need to be put inside of the records like the regular matrixes do.

    self.Overlay:Hitboxes( 
        self.Hitboxes:GetSimpleBones( Record.Target, Group ), 
        self.Config[ 'aimbot_shot_matrix_time' ], 
        self.Config[ 'aimbot_shot_matrix_color' ], 
        true 
    )
end

function Coffee.Shots:Landed( Data )
    if ( not self.Client.Local or not self.Client.Weapon ) then 
        return
    end

    local Inflictor = Player( Data.attacker )

    if ( not IsValid( Inflictor ) or Inflictor != self.Client.Local ) then 
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

        self:PushMatrix( Slot.Record )

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

    if ( not self.Config[ 'world_hitmarker_check_hit' ] or Data.Trace.Entity:IsPlayer( ) ) then 
        self.Hitmarker:New( self.Config[ 'world_hitmarker_time' ], Data.Trace.HitPos )
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

    -- Note this still isn't perfect but I don't know if I could make a non module based check for
    -- this.
    local Timeslot = self.Client.Ping / 4

    if ( Coffee.Ragebot and Coffee.Ragebot.Choked ) then 
        Timeslot = Timeslot + Coffee.Ragebot.Choked
    end

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