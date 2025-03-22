-- Credits to codepen.io for the idea and some of the implementation.
-- https://codepen.io/LeonGr/pen/eYoZJB

function Coffee.Menu:SetupConstellation( )
    for i = 1, 100 do 
        table.insert( self.Dots, {
            x        = math.random( ) * self.Resolution.Width,
            y        = math.random( ) * self.Resolution.Height,
            size     = 2,
            velocity = Vector( math.Rand( -1, 1 ) * 250, math.Rand( -1, 1 ) * 250, 0 )
        } )
    end
end

function Coffee.Menu:HandleConstellationDistance( X1, Y1, X2, Y2 )  
    return math.sqrt( ( X1 - X2 ) ^ 2 + ( Y1 - Y2 ) ^ 2 )
end

function Coffee.Menu:HandleConstellationInput( Dot, Point, Distance, Input, Invert, Range )
    local Scale = 0

    if ( not Input or not input.IsMouseDown( MOUSE_LEFT ) ) then 
        return Scale
    end

    if ( Distance > Range ) then 
        return Scale
    end

    Scale = ( ( Dot - Point ) * ( Invert and 0.05 or 0.25 ) )

    if ( Invert ) then 
        Scale = -Scale
    end

    return Scale
end

function Coffee.Menu:HandleConstellationSoup( Dot, invertSoup, i )
    for i = 1, 100 do 
        local secondaryDot = self.Dots[ i ]
        
        if ( self:HandleConstellationDistance( Dot.x, Dot.y, secondaryDot.x, secondaryDot.y ) < 150 ) then 
            local scaleX = ( ( Dot.x - secondaryDot.x ) * 0.01 )
            local scaleY = ( ( Dot.y - secondaryDot.y ) * 0.01 )

            if ( invertSoup ) then 
                scaleX = -scaleX
                scaleY = -scaleY
            end 

            Dot.x = Dot.x + scaleX
            Dot.y = Dot.y + scaleY
        end
    end

    return Dot
end

function Coffee.Menu:HandleConstellationEdges( X, Y )
    local Input    = self.Config[ 'miscellaneous_constellation_input' ]
    local Invert   = self.Config[ 'miscellaneous_constellation_input_invert' ]
    local Range    = self.Config[ 'miscellaneous_constellation_input_distance' ]

    local Soup       = self.Config[ 'miscellaneous_constellation_equalized' ]
    local invertSoup = self.Config[ 'miscellaneous_constellation_equalized_invert' ]

    local Rate = FrameTime( )

    for i = 1, 100 do 
        local Dot = self.Dots[ i ]

        Dot.x = Dot.x + ( Dot.velocity.x * Rate ) 
        Dot.y = Dot.y + ( Dot.velocity.y * Rate )

        if ( Dot.x < 0 or Dot.x > self.Resolution.Width ) then 
            Dot.velocity.x = -Dot.velocity.x
        end

        if ( Dot.y < 0 or Dot.y > self.Resolution.Height ) then 
            Dot.velocity.y = -Dot.velocity.y          
        end

        local Distance = self:HandleConstellationDistance( Dot.x, Dot.y, X, Y )

        Dot.x = Dot.x + self:HandleConstellationInput( Dot.x, X, Distance, Input, Invert, Range )
        Dot.y = Dot.y + self:HandleConstellationInput( Dot.y, Y, Distance, Input, Invert, Range )

        if ( Soup ) then 
            Dot = self:HandleConstellationSoup( Dot, invertSoup )
        end

        Dot.x = math.Clamp( Dot.x, 0, self.Resolution.Width )
        Dot.y = math.Clamp( Dot.y, 0, self.Resolution.Height )
    end
end

function Coffee.Menu:RenderConstellation( )
    -- Also known as connecting dots.
    if ( not self.Config[ 'miscellaneous_constellation' ] ) then 
        return
    end

    local X, Y = gui.MouseX( ), gui.MouseY( )

    local dotColor  = self.Config[ 'miscellaneous_constellation_dot_color' ]
    local lineColor = self.Config[ 'miscellaneous_constellation_line_color' ]

    -- You could build a spatial grid for this but its not that big of a deal.

    for i = 1, 100 do 
        local Dot = self.Dots[ i ]

        surface.SetDrawColor( lineColor )

        if ( self:HandleConstellationDistance( Dot.x, Dot.y, X, Y ) < 150 ) then 
            surface.DrawLine( Dot.x, Dot.y, X, Y )
        end

        for i = 1, 100 do 
            local secondaryDot = self.Dots[ i ]
            
            if ( self:HandleConstellationDistance( Dot.x, Dot.y, secondaryDot.x, secondaryDot.y ) < 200 ) then 
                surface.DrawLine( Dot.x, Dot.y, secondaryDot.x, secondaryDot.y )
            end
        end

        surface.SetDrawColor( dotColor )
        
        surface.DrawRect( Dot.x, Dot.y, Dot.size, Dot.size )
    end

    self:HandleConstellationEdges( X, Y )
end