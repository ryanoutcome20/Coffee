function Coffee.Menu:GenerateList( Panel, Name, Update )
    -- Have to generate the list panel used by the item list.

    local DCollapsible = vgui.Create( 'DCollapsibleCategory', Panel )
    DCollapsible:SetLabel( Name )
    DCollapsible:Dock( TOP )
    DCollapsible:SetExpanded( false )
    DCollapsible:SetPaintBackground( false )
    DCollapsible:Toggle( )

    DCollapsible.SetExpanded = function( self )

    end

    DCollapsible.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 120 )
        surface.DrawRect( 0, 0, W, H )

        if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
            self.Header:SetTextColor( Coffee.Menu.Color )
        else
            self.Header:SetTextColor( Coffee.Colors[ 'White' ] )
        end
        
        Update( self, Name )
    end

    self.Items.DCollapsible = DCollapsible
end