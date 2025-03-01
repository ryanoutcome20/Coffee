function Coffee.Menu:GenerateLabel( Panel, Text )
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

    -- Set our last for the right docking elements.
    self.Last = Label

    return Label
end