function Coffee.Menu:GenerateDropdown( Panel, Index, Assignment, Options, Width, Callback, useIndex )
    -- Have to generate the dropdowns used in the menu.
	
    Panel = Panel or self.Last

    local Dropdown = vgui.Create( 'DComboBox', Panel )
    Dropdown:SetSize( Width and self:Scale( Width ) or self:Scale( 100 ), 15 )
    Dropdown:Dock( RIGHT )
    Dropdown:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    
    Dropdown:SetValue( Options[ Index ] )
    Coffee.Config[ Assignment ] = useIndex and Index - 1 or Options[ Index ]

    for i = 1, #Options do
        Dropdown:AddChoice( Options[ i ] )
    end

    Dropdown.OnSelect = function( self, Index, Value )
        Coffee.Config[ Assignment ] = useIndex and Index - 1 or Value

        if ( Callback ) then 
            Callback( Value )
        end
    end
	
	Dropdown.OnConfigLoad = function( self )		
		if ( useIndex ) then		
			Dropdown:SetValue( Options[ Coffee.Config[ Assignment ] + 1 ] )
		else
			Dropdown:SetValue( Coffee.Config[ Assignment ] )
		end
		
		if ( Callback ) then 
            Callback( self:GetValue( ) )
        end
	end
	
    Dropdown:SetFont( 'DefaultSmall' )
    
    -- This is terrible but I didn't make the library. You can tell this wasn't made for 
    -- dynamic guis.
    self:GenerateFixedDropdown( Dropdown )

    return Dropdown
end

function Coffee.Menu:GenerateFixedDropdown( Dropdown )
    -- Fix the default box color.
    Dropdown.Paint = function( self, W, H )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        self:SetTextColor( Coffee.Menu.Color )
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
    Dropdown.OnMenuOpened = function( self, Menu )
        -- Horrific code below. VGUI has forced my hand.

        local Children = self:GetChildren( )

        local childFrame = Children[ 1 ]
        local childMenu = Children[ 2 ]

        childFrame.Think = function( self )
            local Parent = self:GetParent( )
            
            if ( Parent and not Parent:IsVisible( ) ) then 
                return self:Remove( )
            end
        end

        childMenu.Paint = function( self, W, H )
            surface.SetDrawColor( 20, 20, 20, 250 )
            surface.DrawRect( 0, 0, W, H )
    
            surface.SetDrawColor( Coffee.Menu.Color )
            surface.DrawOutlinedRect( 0, 0, W, H, 1 )

            -- Comical VGUI moment.
            local Parent = self:GetParent( )

            while ( true ) do -- This runs about 15 times. Thanks Garry.
                local Sub = Parent:GetParent( )

                if ( not Sub ) then 
                    break
                end

                if ( Sub:GetClassName( ) == 'CGModBase' ) then 
                    break
                end
                
                Parent = Sub
            end

            if ( not Parent or not Parent:IsVisible( ) ) then
                self:Remove( ) 
            end
        end
    
        for i = 1, #Dropdown.Choices do 
            local Menu = childMenu:GetChild( i )

            if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
                Menu:SetColor( Coffee.Menu.Color )
            else
                Menu:SetColor( Coffee.Menu.Colors.White ) 
            end
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