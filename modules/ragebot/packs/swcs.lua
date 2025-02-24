Coffee.Ragebot.SWCS = { }

function Coffee.Ragebot.SWCS:RunTrace( Record, Matrix )
    local Trace = util.TraceLine( { start = self.Client.EyePos, endpos = Matrix, filter = { self.Client.Local, Record.Target }, mask = MASK_SHOT } )

    return Trace.Fraction == 1
end