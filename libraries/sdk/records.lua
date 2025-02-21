Coffee.Records = { 
    Client = Coffee.Client,
    Require = Coffee.Require,
    Hitboxes = Coffee.Hitboxes,

    Entities = { },
    Players  = { },

    Cache = { }
}

function Coffee.Records:GetFront( Target )
    local Records = self.Cache[ Target ] or { }

    return Records[ 1 ]
end

function Coffee.Records:MatchCompensation( Target, Current )
    -- Get all records.
    local Records = self.Cache[ Target ]

    if ( #Records < 2 ) then 
        return
    end

    -- Get our delta.
    local Delta = Current.Origin - Records[ 2 ].Origin

    -- Check if we have broken because of speed.
    -- https://github.com/ValveSoftware/source-sdk-2013/blob/0759e2e8e179d5352d81d0d4aaded72c1704b7a9/src/game/server/player_lagcompensation.cpp#L480
    local LC = Current.Origin:DistToSqr( Records[ 2 ].Origin ) > 4096

    -- Loop all of our records to match this stuff.
    local Highest = 0

    for k,v in pairs( Records ) do 
        if ( v.Simtime > Highest ) then 
            Highest = v.Simtime
        else 
            -- This record will be set to the current origin when backtracking which means we'll miss. Ignore it!
            -- https://github.com/ValveSoftware/source-sdk-2013/blob/0759e2e8e179d5352d81d0d4aaded72c1704b7a9/src/game/server/player_lagcompensation.cpp#L510
            -- https://github.com/ValveSoftware/source-sdk-2013/blob/0759e2e8e179d5352d81d0d4aaded72c1704b7a9/src/game/server/player_lagcompensation.cpp#L487
            v.Shift = true
        end

        v.LC = LC
    end
end

function Coffee.Records:Cleanup( )
    for Target, Record in pairs( self.Cache ) do
        if ( Target == NULL or not Target or not IsValid( Target ) ) then 
            self.Cache[ Target ] = nil
        end
    end
end

function Coffee.Records:Construct( Target )
    local Data = {
        Player = Target:IsPlayer( ),
        
        Dormant = Target:IsDormant( ),

        Weapon   = Target:GetActiveWeapon( ),
        Index    = Target:EntIndex( ),

        Health   = Target:Health( ),
        Position = Target:GetPos( ),
        Angles   = Target:EyeAngles( ),
        Origin   = Target:GetNetworkOrigin( ),

        maxHealth = Target:GetMaxHealth( ),

        Mins = Target:OBBMins( ),
        Maxs = Target:OBBMaxs( ),

        Bones = self.Hitboxes:GetMatrixInformation( Target ),

        Shift = false,
        LC = false,
        Fake = false
    }

    Data.Name = Data.Player and Target:Name( ) or Target:GetClass( )

    if ( Data.Player and self.Require ) then 
        Data.Simtime = self.Require:Simulation( Target )
        
        Data.Ping     = Target:Ping( )
        Data.Armor    = Target:Armor( )
        Data.maxArmor = Target:GetMaxArmor( )

        Data.Fake = Data.Angles.z != 0 or math.abs( Data.Angles.x ) > 90 
    end

    return Data
end

function Coffee.Records:Update( Stage )
    if ( Stage != FRAME_NET_UPDATE_POSTDATAUPDATE_END ) then 
        return 
    end

    -- Execute main loop, fill our records with a new one if the player/npc is valid.
    for k, Target in pairs( ents.GetAll( ) ) do
        if ( not Target:IsNPC( ) and not Target:IsPlayer( ) ) then 
            continue
        end

        -- This is a valid entity and therefore it needs an entry.
        self.Cache[ Target ] = self.Cache[ Target ] or { }

        -- If the entity isn't currently valid or we're dead then we can just delete records.
        if ( not self.Client.Alive or Target:IsDormant( ) or not Target:Alive( ) ) then 
            self.Cache[ Target ] = { }
            continue
        end

        -- Insert newly constructed records.
        local newRecord = self:Construct( Target )

        if ( istable( newRecord ) ) then 
            table.insert( self.Cache[ Target ], 1, newRecord )
        end

        -- Update all records in the context with the compensation information.
        if ( newRecord.Player ) then 
            self:MatchCompensation( Target, newRecord )
        end

        -- No need to keep this many records.
        while ( #self.Cache[ Target ] > 64 ) do 
            table.remove( self.Cache[ Target ] )
        end
    end

    -- Cleanup left over NULL entities from players that have left or NPCs that have despawned.
    self:Cleanup( )

    -- Add our all lists for other hooks to use.
    self.Entities = ents.GetAll( )
    self.Players  = player.GetAll( )
end

Coffee.Hooks:New( Coffee.Require:FrameStageNotify( ), Coffee.Records.Update, Coffee.Records )