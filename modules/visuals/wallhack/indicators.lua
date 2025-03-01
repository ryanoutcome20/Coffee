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