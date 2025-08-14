-- Credits to codepen.io for the idea and some of the implementation.
-- https://codepen.io/LeonGr/pen/eYoZJB

function Coffee.Menu:SetupConstellation( )
    for i = 1, 100 do 
        table.insert( self.Dots, {
            X        = math.random( ) * self.Resolution.Width,
            Y        = math.random( ) * self.Resolution.Height,
            Size     = 2,
            Velocity = Vector( math.Rand( -1, 1 ) * 250, math.Rand( -1, 1 ) * 250, 0 )
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
        
        if ( self:HandleConstellationDistance( Dot.X, Dot.Y, secondaryDot.X, secondaryDot.Y ) < 150 ) then 
            local scaleX = ( ( Dot.X - secondaryDot.X ) * 0.01 )
            local scaleY = ( ( Dot.Y - secondaryDot.Y ) * 0.01 )

            if ( invertSoup ) then 
                scaleX = -scaleX
                scaleY = -scaleY
            end 

            Dot.X = Dot.X + scaleX
            Dot.Y = Dot.Y + scaleY
        end
    end

    return Dot
end

function Coffee.Menu:HandleConstellationEdges( X, Y )
    local Input    = Coffee.Config[ 'miscellaneous_constellation_input' ]
    local Invert   = Coffee.Config[ 'miscellaneous_constellation_input_invert' ]
    local Range    = Coffee.Config[ 'miscellaneous_constellation_input_distance' ]

    local Soup       = Coffee.Config[ 'miscellaneous_constellation_equalized' ]
    local invertSoup = Coffee.Config[ 'miscellaneous_constellation_equalized_invert' ]

    local Rate = FrameTime( )

    for i = 1, 100 do 
        local Dot = self.Dots[ i ]

        Dot.X = Dot.X + ( Dot.Velocity.X * Rate ) 
        Dot.Y = Dot.Y + ( Dot.Velocity.Y * Rate )

        if ( Dot.X < 0 or Dot.X > self.Resolution.Width ) then 
            Dot.Velocity.X = -Dot.Velocity.X
        end

        if ( Dot.Y < 0 or Dot.Y > self.Resolution.Height ) then 
            Dot.Velocity.Y = -Dot.Velocity.Y          
        end

        local Distance = self:HandleConstellationDistance( Dot.X, Dot.Y, X, Y )

        Dot.X = Dot.X + self:HandleConstellationInput( Dot.X, X, Distance, Input, Invert, Range )
        Dot.Y = Dot.Y + self:HandleConstellationInput( Dot.Y, Y, Distance, Input, Invert, Range )

        if ( Soup ) then 
            Dot = self:HandleConstellationSoup( Dot, invertSoup )
        end

        Dot.X = math.Clamp( Dot.X, 0, self.Resolution.Width )
        Dot.Y = math.Clamp( Dot.Y, 0, self.Resolution.Height )
    end
end

function Coffee.Menu:RenderConstellation( )
    -- Also known as connecting dots.
    if ( not Coffee.Config[ 'miscellaneous_constellation' ] ) then 
        return
    end

    local X, Y = gui.MouseX( ), gui.MouseY( )

    local dotColor  = Coffee.Config[ 'miscellaneous_constellation_dot_color' ]
    local lineColor = Coffee.Config[ 'miscellaneous_constellation_line_color' ]

    -- You could build a spatial grid for this but its not that big of a deal.

    for i = 1, 100 do 
        local Dot = self.Dots[ i ]

        surface.SetDrawColor( lineColor )

        if ( self:HandleConstellationDistance( Dot.X, Dot.Y, X, Y ) < 150 ) then 
            surface.DrawLine( Dot.X, Dot.Y, X, Y )
        end

        for i = 1, 100 do 
            local secondaryDot = self.Dots[ i ]
            
            if ( self:HandleConstellationDistance( Dot.X, Dot.Y, secondaryDot.X, secondaryDot.Y ) < 200 ) then 
                surface.DrawLine( Dot.X, Dot.Y, secondaryDot.X, secondaryDot.Y )
            end
        end

        surface.SetDrawColor( dotColor )
        
        surface.DrawRect( Dot.X, Dot.Y, Dot.Size, Dot.Size )
    end

    self:HandleConstellationEdges( X, Y )
end