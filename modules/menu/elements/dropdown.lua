function Coffee.Menu:GenerateDropdown( Panel, Index, Assignment, Options, Width )
    -- Have to generate the dropdowns used in the menu.
    
    local Dropdown = vgui.Create( 'DComboBox', Panel or self.Last )
    Dropdown:SetSize( Width and self:Scale( Width ) or self:Scale( 100 ), 15 )
    Dropdown:Dock( RIGHT )
    Dropdown:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    
    Dropdown:SetValue( Options[ Index ] )
    Coffee.Config[ Assignment ] = Options[ Index ]

    for i = 1, #Options do
        Dropdown:AddChoice( Options[ i ] )
    end

    Dropdown.OnSelect = function( self, Index, Value )
        Coffee.Config[ Assignment ] = Value
    end

    -- This is terrible but I didn't make the library. You can tell this wasn't made for 
    -- dynamic guis.
    self:GenerateFixedDropdown( Dropdown )

    return Dropdown
end

function Coffee.Menu:GenerateFixedDropdown( Dropdown )
    -- Fix the default box color.
    Dropdown.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    -- Fix the default hover, clicked, and other colors.
    Dropdown.GetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

    Dropdown.SetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

    -- Fix the default dropdown arrow button.
    Dropdown.DropButton.Paint = function( self, W, H ) end

    -- Fix the entire dropdown menu and every color within the many sub panels.
    Dropdown.OnMenuOpened = function( Panel, Menu )
        -- Horrific code below. VGUI has forced my hand.

        local childMenu = Panel:GetChildren( )[ 2 ]

        childMenu.Paint = function( self, W, H )
            surface.SetDrawColor( 20, 20, 20, 200 )
            surface.DrawRect( 0, 0, W, H )
    
            surface.SetDrawColor( Coffee.Menu.Color )
            surface.DrawOutlinedRect( 0, 0, W, H, 1 )
        end
    
        for i = 1, #Dropdown.Choices do 
            childMenu:GetChild( i ):SetColor( Coffee.Menu.Colors.White ) 
        end

        childMenu.OpenSubMenu = function( Sub )
            local subSub = Sub:GetChildren( )[ 1 ]
            
            for i = 1, #Dropdown.Choices do 
                local subSubSub = subSub:GetChildren( )[ i ]

                subSubSub.Paint = function( self, W, H )
                    if ( not self:IsHovered( ) ) then 
                        return 
                    end
                    
                    surface.SetDrawColor( Coffee.Menu.Color )
                    surface.DrawOutlinedRect( 0, 0, W, H, 1 )
                end
            end
        end
    end
end