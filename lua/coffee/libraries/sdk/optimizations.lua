Coffee.Optimizations = {
    Config = Coffee.Config,

    Enabled = false
}

function Coffee.Optimizations:Valid( Name )
    -- Mostly just here so I don't have to keep writing 'aimbot_optimizations' everywhere.

    return self.Enabled and self.Config[ Name ]
end

function Coffee.Optimizations:Update( )
    self.Enabled = self.Config[ 'aimbot_optimizations' ]
end

Coffee.Hooks:New( 'Move', Coffee.Optimizations.Update, Coffee.Optimizations )