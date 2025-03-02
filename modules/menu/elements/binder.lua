function Coffee.Menu:GenerateKeybind( Panel, Assignment, alwaysOn )
    -- Have to generate the keybinders used in the menu.
    
    local Binder = vgui.Create( 'DBinder', Panel or self.Last )
    Binder:SetFont( 'DefaultSmall' )
    Binder:SetSize( 25, 15 )
    Binder:SetText( '' )
    Binder:Dock( RIGHT )
    Binder:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )

    Coffee.Config[ Assignment ] = 0
    Coffee.Config[ Assignment .. ' Mode' ] = alwaysOn and 'Always On' or 'Hold'

    Binder.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end
    
    Binder.UpdateText = function( self )
        local Name = input.GetKeyName( self:GetSelectedNumber( ) )

        if ( not Name ) then 
            return
        end

        Name = language.GetPhrase( Name )
        
        self:SetText( Name )
        self:SetWide( math.max( math.Clamp( #Name, 1, 9 ) * Coffee.Menu:Scale( 9 ), 25 ) )
    end

    Binder.DoClick = function( self )
        self:SetText( '...' )
        input.StartKeyTrapping()
        self.Trapping = true
    end

    Binder.DoRightClick = function( self )
        Coffee.Menu:GenerateKeybindSubpanel( Assignment )
    end

    Binder.GetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

    Binder.SetTextStyleColor = function( )
        return Coffee.Menu.Color
    end

    Binder.OnChange = function( self, Key )
        Coffee.Config[ Assignment ] = Key
    end

    return Button
end

function Coffee.Menu:GenerateKeybindSubpanel( Assignment )
    -- Have to generate the keybind style menu.

    -- Get main frame that everything will parent too.
    local Frame = vgui.Create( 'DPanel', self.Background )
    Frame:SetPos( gui.MouseX( ), gui.MouseY( ) )
    Frame:SetSize( self:Scale( 125 ), self:Scale( 15 ) )

    Frame.Paint = function( self, W, H ) 
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    Frame.Think = function( self )
        if ( not input.IsMouseDown( MOUSE_LEFT ) and not input.IsMouseDown( MOUSE_RIGHT ) ) then
            return 
        end

        if ( not self:IsHovered( ) and not self:IsChildHovered( ) ) then 
            self:Remove( )
        end
    end

    -- Generate our dropdown.
    local Dropdown = vgui.Create( 'DComboBox', Frame )
    Dropdown:Dock( FILL )
    Dropdown:DockMargin( 0, 0, 0, 0 )

    Dropdown:SetFont( 'DefaultSmall' )

    Dropdown:AddChoice( 'Hold' )
    Dropdown:AddChoice( 'Hold Off' )
    Dropdown:AddChoice( 'Toggle' )
    Dropdown:AddChoice( 'Always On' )

    Dropdown:SetValue( Coffee.Config[ Assignment .. ' Mode' ] )

    Dropdown.OnSelect = function( self, Index, Value )
        Coffee.Config[ Assignment .. ' Mode' ] = Value
    end

    self:GenerateFixedDropdown( Dropdown )
end

function Coffee.Menu:Keydown( Assignment )
    local Key, Mode = Coffee.Config[ Assignment ], Coffee.Config[ Assignment .. ' Mode' ]

    if ( not Key or not Mode ) then 
        return false
    end

    if ( Mode == 'Always On' ) then 
        return true 
    elseif ( Mode == 'Hold Off' ) then
        return not input.IsButtonDown( Key )
    elseif ( Mode == 'Hold' ) then
        return input.IsButtonDown( Key )
    elseif ( Mode == 'Toggle' ) then
        return self.Toggles[ Key ]
    end

    return false
end

function Coffee.Menu:HandleToggles( ENT, Key )   
    self.Toggles[ Key ] = self.Toggles[ Key ] or false 

    if ( self.Toggles[ Key ] ) then 
        self.Toggles[ Key ] = false 
    else 
        self.Toggles[ Key ] = true 
    end 
end

Coffee.Hooks:New( 'PlayerButtonUp', Coffee.Menu.HandleToggles, Coffee.Menu )