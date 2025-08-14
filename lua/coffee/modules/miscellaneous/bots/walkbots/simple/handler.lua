Coffee.Bots.Simple = { 
    Overlay = Coffee.Overlay,
    Client = Coffee.Client,
    Colors = Coffee.Colors,
    Menu   = Coffee.Menu
}

function Coffee.Bots.Simple:IsSurfaceRamped( Predicted, Direction )
    if ( not Coffee.Config[ 'miscellaneous_movement_bot_ramps' ] ) then 
        return false
    end

    local Distance = Coffee.Config[ 'miscellaneous_movement_bot_ramps_distance' ] / 100
    local maxAngle = Coffee.Config[ 'miscellaneous_movement_bot_ramps_angle' ]

    for i = Coffee.Config[ 'miscellaneous_movement_bot_ramps_offset' ], self.Client.Maxs.z do 
        local Trace = util.TraceLine( {
            start  = Vector( Predicted.x, Predicted.y, Predicted.z + i ),
            endpos = Predicted + ( Direction * Distance ),
            filter = self.Client.Local
        } )

        if ( Trace.Hit and Trace.HitNormal ) then
            local Angle = math.deg( math.acos( Trace.HitNormal.z ) )

            if ( Angle < maxAngle ) then
                return true
            else
                return false
            end
        end
    end

    return false
end

function Coffee.Bots.Simple:IsCrossable( Predicted, Direction, Fraction )
    if ( not Coffee.Config[ 'miscellaneous_movement_bot_step' ] ) then 
        return false
    end

    local Distance = Coffee.Config[ 'miscellaneous_movement_bot_step_distance' ] / 100

    local Slot = Predicted + ( Direction * Distance )

    local Trace = util.TraceLine( {
        start  = Vector( Predicted.x, Predicted.y, Predicted.z + self.Client.Step + 1 ),
        endpos = Vector( Slot.x, Slot.y, Slot.z + self.Client.Step + 1 ),
        filter = self.Client.Local
    } )

    return Fraction != 0 and Trace.Fraction > Fraction or Trace.Fraction == 1
end

function Coffee.Bots.Simple:FindWalkablePath( Current, Direction )
    local Used = 0

    for i = 1, Coffee.Config[ 'miscellaneous_movement_bot_ticks' ] do
        Used = Used + 1

        local Predicted = Current + ( Direction * engine.TickInterval( ) )

        local Trace = util.TraceEntityHull( { 
            start = Current, 
            endpos = Predicted, 
            filter = self.Client.Local
        }, self.Client.Local )

        if ( Trace.Fraction != 1 ) then 
            if ( not self:IsCrossable( Predicted, Direction, Trace.Fraction ) ) then 
                if ( not self:IsSurfaceRamped( Predicted, Direction ) ) then 
                    break
                end
            end
        end

        Current = Predicted
    end

    return Used, Current
end

function Coffee.Bots.Simple:GenerateWorkableDirections(Direction)
    local Distance = Coffee.Config[ 'miscellaneous_movement_bot_distance' ]
    
    if ( Direction:Length2D( ) == 0 ) then
        return {
            Vector( Distance, 0, 0 ),
            Vector( -Distance, 0, 0 ),
            Vector( 0, Distance, 0 ),
            Vector( 0, -Distance, 0 ),
            Vector( Distance, Distance, 0 ):GetNormalized( ) * Distance,
            Vector( -Distance, -Distance, 0 ):GetNormalized( ) * Distance,
            Vector( Distance, -Distance, 0 ):GetNormalized( ) * Distance,
            Vector( -Distance, Distance, 0 ):GetNormalized( ) * Distance
        }
    end

    Direction = Direction:GetNormalized( ) * Distance

    Direction.z = 5

    return {
        Direction,
        Vector( -Direction.x, Direction.y, Direction.z ),
        Vector( Direction.x, -Direction.y, Direction.z )
    }
end

function Coffee.Bots.Simple:FindBestPath( Directions, Current )
    local Best;

    local Velocity = Coffee.Config[ 'miscellaneous_movement_bot_velocity' ]

    for i = 1, #Directions do 
        local Data = Directions[ i ]

        if ( Data.Ticks <= 1 ) then 
            continue
        end

        if ( not Best ) then 
            Best = Data
            continue
        end

        if ( Data.End:Distance2D( Current ) < Velocity ) then 
            continue
        end

        if ( Data.Index == self.Last ) then 
            return Data.Direction
        end

        if ( Data.Ticks < Best.Ticks ) then 
            Best = Data
        end
    end

    if ( Best ) then 
        self.Last = Best.Index
        return Best.Direction
    end
end

function Coffee.Bots.Simple:Handler( CUserCMD )
    if ( not Coffee.Config[ 'miscellaneous_movement_bot' ] or not self.Menu:Keydown( 'miscellaneous_movement_bot_keybind' ) ) then 
        return
    end

    local Velocity = self.Client.Velocity

    local Current, Directions = self.Client.Position, self:GenerateWorkableDirections( Velocity )

    local Paths = { }

    for i = 1, #Directions do 
        local Direction = Directions[ i ]

        local Ticks, End = self:FindWalkablePath( Current, Direction )
    
        table.insert( Paths, {
            Direction = Direction,
            Ticks     = Ticks,
            End       = End,
            Index     = i
        } )
    end

    local Best = self:FindBestPath( Paths, Current )

    if ( not Best ) then 
        return
    end

    CUserCMD:SetForwardMove( 10000 )
    CUserCMD:SetSideMove( 0 )

    CUserCMD:SetViewAngles( Best:Angle( ) )
end