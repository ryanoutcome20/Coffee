function Coffee.Menu:GenerateLabel( Panel, Text, avoidLast )
    -- Have to generate the labels for things to dock too.

    -- Generate our label.
    local Label = vgui.Create( 'DLabel', Panel )
    Label:SetText( Text )
    Label:SetFont( 'DefaultSmall' )
	Label:SizeToContents( )
    Label:SetMouseInputEnabled( true )    
    Label:Dock( TOP )
    Label:DockMargin( 0, 0, 0, self:Scale( 5 ) )
    Label:SetTall( 15 )

    Label.Think = function( self )
        if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
            self:SetTextColor( Coffee.Menu.Color )
        else
            self:SetTextColor( Coffee.Colors[ 'White' ] )
        end
    end

    -- Set our last for the right docking elements.
    if ( not avoidLast ) then 
        self.Last = Label
    end

    return Label
end