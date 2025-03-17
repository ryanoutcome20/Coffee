Coffee.Hitmarker = { 
    Resolution = Coffee.Resolution,
    Config     = Coffee.Config,

    Cache = { }
}

function Coffee.Hitmarker:New( Duration, World )
    local Data = {
        Duration = Duration,
        World    = World,

        Time  = CurTime( )
    }

    Data.End = Data.Time + Data.Duration
    
    table.insert( self.Cache, Data )
end

function Coffee.Hitmarker:Draw( X, Y, Space, Length, Color, Alpha, useAlpha )
    surface.SetDrawColor( Color.r, Color.g, Color.b, useAlpha and Alpha or Color.a )
    surface.DrawLine( X - Space, Y - Space, X - Length, Y - Length )
    surface.DrawLine( X - Space, Y + Space, X - Length, Y + Length )
    surface.DrawLine( X + Space, Y + Space, X + Length, Y + Length )
    surface.DrawLine( X + Space, Y - Space, X + Length, Y - Length )
end

function Coffee.Hitmarker:Render( )
    if ( not self.Config[ 'world_hitmarker' ] ) then
        return 
    end

    local Finished = { }
    local Time     = CurTime( )

    local Mode     = self.Config[ 'world_hitmarker_mode' ]
    local useAlpha = self.Config[ 'world_hitmarker_fade' ]

    for k, Data in pairs( self.Cache ) do
        -- Check world hitmarker.
        if ( Data.World and Mode == '2D' ) then 
            continue
        elseif ( not Data.World and Mode == '3D' ) then 
            continue
        end
        
        -- Check timer.
        if ( Time >= Data.End ) then 
            continue
        end

        -- Get configuration options.
        local Space  = self.Config[ 'world_hitmarker_space' ]
        local Offset = Space / self.Config[ 'world_hitmarker_length' ] 

        -- Get alpha.
        local Alpha = 0

        if ( useAlpha ) then 
            Alpha = ( 1 - ( ( Time - Data.Time ) / Data.Duration ) ) * 255
        end

        -- Get position.
        local X, Y = 0, 0

        if ( Data.World ) then 
            local Position = Data.World:ToScreen()

            X, Y = Position.x, Position.y
        else
            X, Y  = self.Resolution.Width / 2, self.Resolution.Height / 2
        end

        -- Render secondary overlay.
        if ( self.Config[ 'world_hitmarker_overlay' ] ) then 
            self:Draw( 
                X, 
                Y, 
                self.Config[ 'world_hitmarker_overlay_space' ], 
                Offset, 
                self.Config[ 'world_hitmarker_overlay_color' ],
                Alpha,
                useAlpha
            )
        end
        
        -- Render primary overlay.
        self:Draw( 
            X, 
            Y, 
            Space, 
            Offset, 
            self.Config[ 'world_hitmarker_color' ],
            Alpha,
            useAlpha
        )

        table.insert( Finished, Data )
    end

    self.Cache = Finished
end

Coffee.Hooks:New( 'DrawOverlay', Coffee.Hitmarker.Render, Coffee.Hitmarker )