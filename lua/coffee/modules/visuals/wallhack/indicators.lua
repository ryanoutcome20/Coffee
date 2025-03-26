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
    local Target = self.Config[ 'miscellaneous_notifications_color' ]

    for k, Index in ipairs( Cache ) do
        if ( not Index.Delta ) then 
            continue
        end

        local Alpha = math.Clamp( ( Index.Delta / 0.5 ) * 255, 0, 255 )

        surface.SetTextColor( Color( Target.r, Target.g, Target.b, Alpha ) )

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
    
    local Text = string.format( 'Coffee - %s - KD %s', os.date( '%X' ), math.Round( Kills / Deaths, 1 ) )

    -- Get coordinates.
    local X, Y = self.Resolution.Width - 10, 5
    
    -- Set our text fonts.
    surface.SetFont( 'DebugOverlay' )

    -- Get our text size.
    local tW, tH = surface.GetTextSize( Text )

    -- Get our width and height.
    local W, H = tW + 8, 15

    -- Render glowing outline.
    local Target  = self.Config[ 'miscellaneous_watermark_color' ]
    local Outline = Color( Target.r, Target.g, Target.b )

    local Intensity = ( 0.25 + math.abs( math.sin( CurTime( ) ) ) )

    for i = 1, 5 do
        local Inverted = ( 5 - i ) + 1

        Outline.a = ( 4 * Inverted ) * Intensity

        draw.RoundedBox( 8, ( X - tW - 5 ) - i, Y - i, W + i * 2, H + i * 2, Outline )
    end

    -- Render backdrop.
    draw.RoundedBox( 4, X - tW - 5, Y, W, H, self.Config[ 'miscellaneous_watermark_background_color' ] )

    -- Render text.
    surface.SetTextColor( self.Config[ 'miscellaneous_watermark_text_color' ] )
    surface.SetTextPos( X - tW, Y ) 
    surface.DrawText( Text )
end