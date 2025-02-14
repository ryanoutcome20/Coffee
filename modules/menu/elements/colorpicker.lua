function Coffee.Menu:GenerateColorpicker( Panel, Assignment, Color, Callback )
    -- Have to generate the colorpicker buttons used in the menu.
  
    Coffee.Config[ Assignment ] = Color

    local Button = vgui.Create( 'DButton', Panel or self.Last )
    Button:SetSize( 15, 15 )
    Button:SetText( '' )
    Button:Dock( RIGHT )
    Button:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )

    Button.Paint = function( self, W, H )
        surface.SetMaterial( Coffee.Menu.Gradients.Grid )
        surface.SetDrawColor( 255, 255, 255 )
        surface.DrawTexturedRect( 0, 0, W, H )

        -- Don't draw a regular box, we want those little corners.
        surface.SetDrawColor( Coffee.Config[ Assignment ] )
        surface.DrawRect( 0, 0, W, H )
    end

    Button.DoClick = function( self, W, H )
        Coffee.Menu:GenerateColorpickerWindow( Assignment, Coffee.Config[ Assignment ], Callback )
    end

    Button.DoRightClick = function( self, W, H )
        Coffee.Menu:GenerateColorpickerSubPanel( Assignment )
    end

    return Button
end

function Coffee.Menu:GenerateColorpickerWindow( Assignment, Color, Callback )
    -- Have to generate the colorpicker frames used in the menu.

    -- Get main frame that everything will parent too.
    local Frame = vgui.Create( 'DFrame', self.Background )
    Frame:SetPos( gui.MouseX( ), gui.MouseY( ) )
    Frame:SetSize( self:Scale( 155 ), self:Scale( 155 ) )
    Frame:ShowCloseButton( false )
    Frame:SetDraggable( false )
    Frame:SetTitle( '' )

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

    -- Get the color cube, this is the main big square you're interacting with.
    local Cube = vgui.Create( 'DColorCube', Frame )
    Cube:SetPos( self:Scale( 5 ), self:Scale( 5 ) )
    Cube:SetSize( self:Scale( 135 ), self:Scale( 135 ) )
    Cube:SetColor( Color )

    Cube.OnUserChanged = function( self, Color )
        Coffee.Config[ Assignment ] = Color

        if ( Callback ) then 
            Callback( Color )
        end
    end

    -- Get the RGB picker, this is the slider that controls hue.
    local Picker = vgui.Create( 'DRGBPicker', Frame )
    Picker:SetPos( self:Scale( 142 ), self:Scale( 5 ) )
    Picker:SetSize( self:Scale( 10 ), self:Scale( 135 ) )
    Picker:SetRGB( Color )

    Picker.Think = function( self )
        self.LastX = math.Clamp( self.LastX, 1, self:GetWide( ) - 1 )
        self.LastY = math.Clamp( self.LastY, 1, self:GetTall( ) - 1 )
    end

    Picker.OnChange = function( self, Color )
        local H = ColorToHSV( Color )
        local _, S, V = ColorToHSV( Cube:GetRGB( ) )

        Color = HSVToColor( H, S, V )
        Cube:SetBaseRGB( HSVToColor( H, 1, 1 ) )

        Coffee.Config[ Assignment ] = Color
        
        if ( Callback ) then 
            Callback( Color )
        end
    end

    -- Get the alpha picker.
    local Alpha = vgui.Create( 'DRGBPicker', Frame )
    Alpha:SetPos( self:Scale( 5 ), self:Scale( 142 ) )
    Alpha:SetSize( self:Scale( 135 ), self:Scale( 10 ) )

    Alpha.Think = function( self )
        self.LastX = math.Clamp( self.LastX, 1, self:GetWide( ) - 1 )
        self.LastY = math.Clamp( self.LastY, 1, self:GetTall( ) - 1 )
    end

    -- We're just going to edit the default RGB picker to get it to work.
    Alpha.LastX = math.Remap( Color.a, 1, 255, 1, Alpha:GetWide( ) )
    Alpha.Material = self.Gradients.Grid

    Alpha.Paint = function( self, W, H )
        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( 0, 0, W, H, 1 )

        surface.SetMaterial( Coffee.Menu.Gradients.Left )
        surface.SetDrawColor( 0, 0, 0, 255 )
        surface.DrawTexturedRect( 0, 0, W, H, 1 )

        surface.SetDrawColor( 0, 0, 0, 250 )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        surface.DrawRect( self.LastX - 2, 0, 3, H )

        surface.SetDrawColor( 255, 255, 255, 250 )
        surface.DrawRect( self.LastX - 1, 0, 1, H )
    end

    Alpha.OnChange = function( self )
        if ( not Coffee.Config[ Assignment ] ) then 
            return
        end

        Coffee.Config[ Assignment ].a = math.Remap( self.LastX, 1, self:GetWide( ), 1, 255 )
    end
end

function Coffee.Menu:GenerateColorpickerSubPanel( Assignment )
    -- Have to generate the colorpicker copy and paste menu.

    -- Get main frame that everything will parent too.
    local Frame = vgui.Create( 'DPanel', self.Background )
    Frame:SetPos( gui.MouseX( ), gui.MouseY( ) )
    Frame:SetSize( self:Scale( 35 ), self:Scale( 50 ) - 1 )

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

    -- Get the save button.
    self:GenerateButton( Frame, 'Save', function( self )
        Coffee.Menu.Copied = Coffee.Config[ Assignment ]
        
        Frame:Remove( )
    end, function( self )
        self:DockMargin( 0, 0, 0, Coffee.Menu:Scale( 5 ) )
    end )

    -- Get the load button.
    self:GenerateButton( Frame, 'Load', function( self )
        Coffee.Config[ Assignment ] = Coffee.Menu.Copied

        Frame:Remove( )
    end, function( self )
        self:DockMargin( 0, 0, 0, Coffee.Menu:Scale( 5 ) )
    end )
end