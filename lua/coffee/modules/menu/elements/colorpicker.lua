function Coffee.Menu:GenerateColorpicker( Panel, Assignment, Default, Callback )
    -- Have to generate the colorpicker buttons used in the menu.
  
    Panel = Panel or self.Last

    -- Disassociate the default color object with the current color array.
    Default = Color( Default.r, Default.g, Default.b, Default.a )

    Coffee.Config[ Assignment ] = Default

    local Button = vgui.Create( 'DButton', Panel )
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
        Coffee.Menu:GenerateColorpickerWindow( Panel, Assignment, Coffee.Config[ Assignment ], Callback )
    end

    Button.DoRightClick = function( self, W, H )
        if ( input.IsButtonDown( KEY_LSHIFT	) ) then 
            local Color = Coffee.Config[ Assignment ]

            SetClipboardText( string.format( 'Color( %s, %s, %s )', Color.r, Color.g, Color.b ) )

            return
        end

        Coffee.Menu:GenerateColorpickerSubPanel( Panel, Assignment, Callback )
    end
	
	Button.OnConfigLoad = function( self )
	    if ( Callback ) then 
            Callback( Coffee.Config[ Assignment ] )
        end
	end

    return Button
end

function Coffee.Menu:GenerateColorpickerWindow( Panel, Assignment, Color, Callback )
    -- Have to generate the colorpicker frames used in the menu.

    -- Get main frame that everything will parent too.
    local Frame = vgui.Create( 'DFrame', Panel )
    Frame:SetPos( gui.MouseX( ), gui.MouseY( ) )
    Frame:SetSize( self:Scale( 155 ), self:Scale( 155 ) )
    Frame:ShowCloseButton( false )
    Frame:SetDraggable( false )
    Frame:SetTitle( '' )
    Frame:MakePopup( )

    Frame.Paint = function( self, W, H ) 
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    Frame.Think = function( self )
        local Parent = self:GetParent( )

        if ( Parent and not Parent:IsVisible( ) ) then 
            return self:Remove( )
        end

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

    Cube.Knob:SetSize( 5, 5 )
    
    Cube.Knob.Paint = function( self, W, H )
        draw.RoundedBox( 32, 0, 0, W, H, Coffee.Menu.Colors.White )
    end

    Cube.OnUserChanged = function( self, Color )
        Color.a = Coffee.Config[ Assignment ].a

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
        self.LastX = math.Clamp( self.LastX, 0, self:GetWide( ) )
        self.LastY = math.Clamp( self.LastY, 0, self:GetTall( ) )
    end

    Picker.OnChange = function( self, Color )
        local H = ColorToHSV( Color )
        local _, S, V = ColorToHSV( Cube:GetRGB( ) )

        Color = HSVToColor( H, S, V )
        Cube:SetBaseRGB( HSVToColor( H, 1, 1 ) )

        Color.a = Coffee.Config[ Assignment ].a

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
        self.LastX = math.Clamp( self.LastX, 1, self:GetWide( ) )
        self.LastY = math.Clamp( self.LastY, 1, self:GetTall( ) )
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

        if ( Callback ) then 
            Callback( Coffee.Config[ Assignment ] )
        end
    end
end

function Coffee.Menu:GenerateColorpickerSubPanel( Panel, Assignment, Callback )
    -- Have to generate the colorpicker copy and paste menu.

    -- Get main frame that everything will parent too.
    local Frame = vgui.Create( 'DPanel', Panel )
    Frame:SetPos( gui.MouseX( ), gui.MouseY( ) )
    Frame:SetSize( self:Scale( 60 ), self:Scale( 50 ) - 1 )
    Frame:MakePopup( )

    Frame.Paint = function( self, W, H ) 
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    Frame.Think = function( self )
        local Parent = self:GetParent( )

        if ( Parent and not Parent:IsVisible( ) ) then 
            return self:Remove( )
        end

        if ( not input.IsMouseDown( MOUSE_LEFT ) and not input.IsMouseDown( MOUSE_RIGHT ) ) then
            return 
        end

        if ( not self:IsHovered( ) and not self:IsChildHovered( ) ) then 
            self:Remove( )
        end
    end

    -- Get the save button.
    self:GenerateButton( Frame, 'Copy', function( self )
        local Current = Coffee.Config[ Assignment ]
        
        Coffee.Menu.Copied = Color( Current.r, Current.g, Current.b, Current.a )
        
        Frame:Remove( )
    end, function( self )
        self:DockMargin( 0, 0, 0, Coffee.Menu:Scale( 5 ) )
    end )

    -- Get the load button.
    self:GenerateButton( Frame, 'Paste', function( self )
        local New = Coffee.Menu.Copied

        Coffee.Config[ Assignment ] = Color( New.r, New.g, New.b, New.a )

        Frame:Remove( )

        if ( Callback ) then 
            Callback( Coffee.Config[ Assignment ] )
        end
    end, function( self )
        self:DockMargin( 0, 0, 0, Coffee.Menu:Scale( 5 ) )
    end )
end