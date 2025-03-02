function Coffee.Visuals:Watermark( )
    if ( not self.Config[ 'miscellaneous_watermark' ] ) then 
        return
    end

    -- Get text.
    local KD   = math.Round( self.Client.Local:Frags( ) / self.Client.Local:Deaths( ), 1 )

    local Text = string.format( 'Coffee - Ping %s - KD %s', self.Client.Ping, KD )

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

    for i = 1, 5 do
        local Inverted = ( 5 - i ) + 1

        Outline.a = 5 * Inverted

        draw.RoundedBox( 8, ( X - tW - 5 ) - i, Y - i, W + i * 2, H + i * 2, Outline )
    end

    -- Render backdrop.
    draw.RoundedBox( 4, X - tW - 5, Y, W, H, Color( 18, 18, 18, 200 ) )

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