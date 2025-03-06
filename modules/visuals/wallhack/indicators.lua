function Coffee.Visuals:Notifications( )
    local Time, Cache = CurTime( ), self.Notify.Cache

    for k, Index in ipairs( Cache ) do 
        Index.Delta = ( Index.Time + Index.Decay ) - Time

        if ( Index.Delta < 0 ) then 
            table.remove( Cache, k )
            continue
        end
    end

    if ( not self.Config[ 'miscellaneous_notifications' ] ) then 
        return
    end

    -- Get coordinates.
    local X, Y = self.Resolution.Width - 10, 5

    if ( self.Config[ 'miscellaneous_watermark' ] ) then 
        Y = Y + 20
    end
    
    -- Set font.
    surface.SetFont( 'DebugOverlay' )

    -- Draw notifications.
    local Offset = 0

    for k, Index in ipairs( Cache ) do
        if ( not Index.Delta ) then 
            continue
        end

        local Alpha = math.Clamp( ( Index.Delta / 0.5 ) * 255, 0, 255 )

        surface.SetTextColor( Color( self.Colors.White.r, self.Colors.White.g, self.Colors.White.b, Alpha ) )

        local tW, tH = surface.GetTextSize( Index.Text )
        surface.SetTextPos( X - tW, Y + Offset ) 
        surface.DrawText( Index.Text )

        Offset = Offset + tH + 2
    end
end

function Coffee.Visuals:Watermark( )
    if ( not self.Config[ 'miscellaneous_watermark' ] or not self.Client.Local ) then 
        return
    end

    -- Get text.
    local Kills  = math.max( self.Client.Local:Frags( ), 1 )
    local Deaths = math.max( self.Client.Local:Deaths( ), 1 )
    
    local Text = string.format( 'Coffee - Ping %s - KD %s', self.Client.Ping, math.Round( Kills / Deaths, 1 ) )

    -- Get coordinates.
    local X, Y = self.Resolution.Width - 10, 5
    
    -- Set our text fonts.
    surface.SetFont( 'DebugOverlay' )

    -- Get our text size.
    local tW, tH = surface.GetTextSize( Text )

    -- Get our width and height.
    local W, H = tW + 8, 15

    -- Render glowing outline.
    local Outline = Color( self.Menu.Color.r, self.Menu.Color.g, self.Menu.Color.b )

    local Intensity = ( 0.25 + math.abs( math.sin( CurTime( ) ) ) )

    for i = 1, 5 do
        local Inverted = ( 5 - i ) + 1

        Outline.a = ( 4 * Inverted ) * Intensity

        draw.RoundedBox( 8, ( X - tW - 5 ) - i, Y - i, W + i * 2, H + i * 2, Outline )
    end

    -- Render backdrop.
    local Background = Color( self.Colors[ 'Dark Gray' ].r, self.Colors[ 'Dark Gray' ].g, self.Colors[ 'Dark Gray' ].b )

    Background.a = 200

    draw.RoundedBox( 4, X - tW - 5, Y, W, H, Background )

    -- Render text.
    surface.SetTextColor( self.Menu.Color )
    surface.SetTextPos( X - tW, Y ) 
    surface.DrawText( Text )
end

function Coffee.Visuals:Indicators( )
    if ( not self.Config[ 'esp_indicators' ] ) then 
        return
    end

    local Indicators = { }

    if ( self.Config[ 'esp_indicators_lc' ] ) then 
        table.insert( Indicators, {
            Name  = 'LC',
            Color = self.Client.LC and self.Colors.Green or self.Colors.Red
        } )
    end

    if ( self.Config[ 'esp_indicators_choke' ] ) then 
        local Valid = self.Ragebot.Choked > ( self.Config[ 'hvh_fakelag_ticks' ] / 2 )

        table.insert( Indicators, {
            Name  = 'Choke',
            Color = Valid and self.Colors.Green or self.Colors.Red
        } )
    end

    if ( self.Config[ 'esp_indicators_invert' ] and self.Menu:Keydown( 'hvh_yaw_invert' ) ) then 
        table.insert( Indicators, {
            Name  = 'Inverted',
            Color = self.Colors.Green
        } )
    end

    for i = 1, #Indicators do 
        local Target = Indicators[ i ]
    
        surface.SetFont( 'HudDefault' )
        surface.SetTextColor( Target.Color )
        surface.SetTextPos( 15, self.Resolution.Height - ( 25 * i ) )
        surface.DrawText( Target.Name )
    end
end