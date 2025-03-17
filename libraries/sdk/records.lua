Coffee.Records = { 
    Client = Coffee.Client,
    Config = Coffee.Config,
    Require = Coffee.Require,
    Hitboxes = Coffee.Hitboxes,
    Fullupdate = Coffee.Fullupdate,
    Optimizations = Coffee.Optimizations,

    Entities = { },
    Players  = { },

    Cache = { }
}

RunConsoleCommand( 'cl_interp', 0 )
RunConsoleCommand( 'cl_interp_ratio', 0 )

function Coffee.Records:GetFront( Target )
    local Records = self.Cache[ Target ] or { }

    return Records[ 1 ]
end

function Coffee.Records:GetIdeal( CUserCMD, Target, Inverse )
    local Records = table.Copy( self.Cache[ Target ] ) or { }
    local Best;

    table.remove( Records, 1 )

    if ( Inverse ) then 
        Records = table.Reverse( Records )
    end

    for k, Record in pairs( Records ) do 
        if ( not self:Valid( CUserCMD, Record ) or k == 1 ) then 
            continue
        end

        if ( Record.Shift ) then
            continue
        end

        Best = Record
    end

    return Best
end

function Coffee.Records:GetLast( CUserCMD, Target )
    local Records = table.Copy( self.Cache[ Target ] ) or { }
    local Last;

    table.remove( Records, 1 )

    Records = table.Reverse( Records )

    for k, Record in pairs( Records ) do 
        if ( not self:Valid( CUserCMD, Record ) or k == 1 ) then 
            continue
        end

        if ( Record.Shift ) then
            continue
        end

        return Record
    end
end

function Coffee.Records:GetTickDelta( CUserCMD, Time )
    return ( self.Require:Servertime( CUserCMD ) + self.Require:Latency( 0 ) + self.Require:Latency( 1 ) ) - Time
end

function Coffee.Records:Valid( CUserCMD, Record )
    if ( Record.LC ) then 
        return false
    end

    return self:GetTickDelta( CUserCMD, Record.Simtime ) < 1
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

    for k,v in pairs( table.Reverse( Records ) ) do 
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

function Coffee.Records:GenerateAnimationData( Target )
    local Animations = { 
        Sequence = Target:GetSequence( ),
        Cycle    = Target:GetCycle( ),
        Color    = Target:GetColor( ),
        Angles   = Target:EyeAngles( ),

        Layers = { },
        Poses  = { }
    }

    local Layer = 0

    while ( true ) do
        Layer = Layer + 1
        
        if ( not Target:IsValidLayer( Layer ) ) then
            -- I have no idea if these start at zero index so this is here just in case.
            if ( Layer == 1 ) then 
                continue    
            end

            break
        end

        local ID = Layer - 1

        Animations.Layers[ ID ] = {
            Weight   = Target:GetLayerWeight( ID ),
            Cycle    = Target:GetLayerCycle( ID ),
            Duration = Target:GetLayerDuration( ID ),
            Playback = Target:GetLayerPlaybackRate( ID )
        }
    end

    for i = 0, Target:GetNumPoseParameters( ) - 1 do 
        Animations.Poses[ i ] = Target:GetPoseParameter( i )
    end

    return Animations
end

function Coffee.Records:Cleanup( )
    for Target, Record in pairs( self.Cache ) do
        if ( Target == NULL or not Target or not IsValid( Target ) ) then 
            self.Cache[ Target ] = nil
        elseif ( Target and not Target:Alive( ) ) then 
            self.Cache[ Target ] = { }
        end
    end
end

function Coffee.Records:Construct( Target, noBones )
    local Data = {
        Target = Target,

        Player = Target:IsPlayer( ),
        
        Dormant = Target:IsDormant( ),

        Weapon   = Target:GetActiveWeapon( ),
        Index    = Target:EntIndex( ),

        Health   = Target:Health( ),
        Position = Target:GetPos( ),
        Angles   = Target:EyeAngles( ),
        Velocity = Target:GetVelocity( ),
        Origin   = Target:GetNetworkOrigin( ),

        Ground   = Target:IsFlagSet( FL_ONGROUND ),
        Duck     = Target:IsFlagSet( FL_DUCKING ),

        maxHealth = Target:GetMaxHealth( ),

        Mins = Target:OBBMins( ),
        Maxs = Target:OBBMaxs( ),

        Shift = false,
        LC = false,
        Fake = false
    }

    Data.Name = Data.Player and Target:Name( ) or Target:GetClass( )
    Data.Speed = Data.Velocity:LengthSqr( )

    if ( Data.Player and self.Require ) then 
        Data.Simtime = self.Require:Simulation( Target )
        
        Data.Ping     = Target:Ping( )
        Data.Armor    = Target:Armor( )
        Data.maxArmor = Target:GetMaxArmor( )

        Data.Fake = Data.Angles.z != 0 or math.abs( Data.Angles.x ) == 180 

        Data.Animations = self:GenerateAnimationData( Target )
    end

    if ( not noBones ) then 
        Data.Bones = self.Hitboxes:GetMatrixInformation( Target )
    end

    return Data
end

function Coffee.Records:Update( Stage )
    if ( Stage != FRAME_NET_UPDATE_POSTDATAUPDATE_END ) then 
        return 
    end

    if ( self.Fullupdate:IsUpdating( ) ) then 
        return
    end

    -- Check if we are using a smaller record frame.
    local Maximum = self.Optimizations:Valid( 'aimbot_optimizations_small_records' ) and 3 or 67
    
    -- Check if we are using no bone matrixes.
    local Bones = self.Optimizations:Valid( 'aimbot_optimizations_hitboxes' )

    -- Execute main loop, fill our records with a new one if the player/npc is valid.
    for k, Target in pairs( ents.GetAll( ) ) do
        if ( not Target:IsNPC( ) and not Target:IsPlayer( ) ) then 
            continue
        end

        -- This is a valid entity and therefore it needs an entry.
        self.Cache[ Target ] = self.Cache[ Target ] or { }

        -- If the entity isn't currently valid or we're dead then we can just delete records.
        if ( not self.Client.Alive or Target:IsDormant( ) or not Target:Alive( ) or Target:IsFlagSet( FL_FROZEN	) ) then 
            self.Cache[ Target ] = { }
            continue
        end

        -- Insert newly constructed records.
        local newRecord = self:Construct( Target, Bones )

        if ( istable( newRecord ) ) then 
            table.insert( self.Cache[ Target ], 1, newRecord )
        end

        -- Update all records in the context with the compensation information.
        if ( newRecord.Player ) then 
            self:MatchCompensation( Target, newRecord )
        end

        -- No need to keep this many records.
        while ( #self.Cache[ Target ] > Maximum ) do 
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

concommand.Add( 'records', function( )
    for k,v in pairs( player.GetAll() ) do 
        MsgN( table.Count( Coffee.Records.Cache[ v ]  ) )
    end
end )