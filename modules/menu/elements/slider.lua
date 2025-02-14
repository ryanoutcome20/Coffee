function Coffee.Menu:GenerateSlider( Panel, Assignment, Minimum, Maximum, Default, Decimals, noLabel, Prefix )
    -- Have to generate the sliders used throughout the menu.

    -- Set our default.
    Coffee.Config[ Assignment ] = Default

    -- Generate the main slider.
    local Slider = vgui.Create( 'DSlider', Panel or self.Last )    
    Slider:SetSize( self:Scale( 100 ), 15 )
    Slider:Dock( RIGHT )
    Slider:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    Slider:SetSlideX( Default / Maximum )

    -- Add some paint to this empty slider.
    Slider.Paint = function( self, W, H )
        -- Get color.
        local Color = Color( Coffee.Menu.Color.r, Coffee.Menu.Color.g, Coffee.Menu.Color.b )

        Color.a = 120

        -- Get value.
        local Value = Coffee.Config[ Assignment ]

        -- Render overlay.
        surface.SetDrawColor( Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
            
        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.DrawTexturedRect( 0, 0, W * ( Value / Maximum ), H )
    
        -- Render label.
        if ( not noLabel and ( self:IsHovered( ) or self:GetDragging( ) ) ) then 
            Color.a = 35

            surface.SetFont( 'DefaultFixedDropShadow' )
            surface.SetTextColor( Color )
            surface.SetTextPos( W * ( Value / Maximum ) + Coffee.Menu:Scale( 5 ), 2 ) 
            surface.DrawText( Value .. ( Prefix or '' ) )
        end
    end

    Slider.Knob.Paint = function( self, W, H ) end

    -- Add the actual value feature.
    Slider.OnValueChanged = function( self, X, Y )
        Coffee.Config[ Assignment ] = math.Round( Maximum * X, Decimals )
    end

    return Slider
end