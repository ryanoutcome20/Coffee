function Coffee.Menu:GenerateCheckbox( Panel, Text, Assignment, Callback )
    -- Have to generate the checkboxes used in the menu.

    -- Generate main checkbox handler.
	local Checkbox = vgui.Create( 'DCheckBoxLabel', Panel )
	Checkbox:Dock( TOP )
    Checkbox:DockMargin( 0, 0, 0, self:Scale( 5 ) )
	Checkbox:SetText( Text )
	Checkbox:SetValue( Coffee.Config[ Assignment ] )
	Checkbox:SizeToContents( )
    
    Checkbox.OnChange = function( self, Value )
        Coffee.Config[ Assignment ] = Value

        if ( Callback ) then 
            Callback( Value )
        end
    end
    
    -- Fix layout and painting on button.
    Checkbox.Button:Dock( LEFT )

    Checkbox.Button.Paint = function( self, W, H )
        surface.SetDrawColor( Coffee.Config[ Assignment ] and Coffee.Menu.Color or Coffee.Menu.Colors[ 'Dark Gray' ] )
        surface.DrawRect( 0, 0, W, H )
    end

    -- Fix font and layout on label.
    Checkbox.Label:SetFont( 'DefaultSmall' )
    Checkbox.Label:Dock( LEFT )
    Checkbox.Label:DockMargin( self:Scale( 5 ), 0, 0, 0 )

    Checkbox.Label.Think = function( self )
        if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
            self:SetTextColor( Coffee.Menu.Color )
        else
            self:SetTextColor( Coffee.Colors[ 'White' ] )
        end
    end

    -- Set our last for the right docking elements.
    self.Last = Checkbox

    return Checkbox
end