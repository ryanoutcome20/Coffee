function TIME_TO_TICKS( Time )
    return math.floor( 0.5 + Time / engine.TickInterval( ) )
end

function TICKS_TO_TIME( Tick )
    return engine.TickInterval( ) * Tick
end