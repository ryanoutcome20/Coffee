function Coffee.Menu:GenerateInput( Panel, Text, Assignment, Callback )
    -- Have to generate the little input boxes for users to type in.

    Text  = Text or 'Lorem ipsum'
    Panel = Panel or self.Last

	local Input = vgui.Create( 'DTextEntry', Panel )
    Input:SetText( Text )
    Input:SetFont( 'DefaultSmall' )
    Input:SetMouseInputEnabled( true )    
    Input:SetKeyboardInputEnabled( true )    
    Input:Dock( RIGHT )
    Input:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    Input:SetTall( 15 )
    Input:SetWide( 125 )

    Coffee.Config[ Assignment ] = Text

    Input.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        self:SetTextColor( Coffee.Menu.Color )
        self:DrawTextEntryText( Coffee.Menu.Color, Coffee.Menu.Color, Coffee.Menu.Color )
    end

    Input.GetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

    Input.SetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

	Input.OnEnter = function( self )
        local Value = self:GetValue( )

		Coffee.Config[ Assignment ] = Value

        if ( Callback ) then 
            Callback( Value )
        end
	end
end