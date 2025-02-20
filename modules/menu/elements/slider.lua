function Coffee.Menu:GenerateSlider( Panel, Assignment, Minimum, Maximum, Default, Decimals, noLabel, Prefix )
    -- Have to generate the sliders used throughout the menu.

    -- Set our default.
    Coffee.Config[ Assignment ] = Default

    -- Generate the main slider.
    local Slider = vgui.Create( 'DSlider', Panel or self.Last )    
    Slider:SetSize( self:Scale( 100 ), 15 )
    Slider:Dock( RIGHT )
    Slider:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    Slider:SetSlideX((Default - Minimum) / (Maximum - Minimum))

    -- Add some paint to this empty slider.
    Slider.Paint = function( self, W, H )
        -- Get color.
        local Color = Color( Coffee.Menu.Color.r, Coffee.Menu.Color.g, Coffee.Menu.Color.b )

        Color.a = 120

        -- Get value.
        local Value = ( ( Coffee.Config[ Assignment ] - Minimum ) / ( Maximum - Minimum ) )

        -- Render overlay.
        surface.SetDrawColor( Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
            
        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.DrawTexturedRect( 0, 0, W * Value, H )
    
        -- Render label.
        if ( not noLabel and ( self:IsHovered( ) or self:IsChildHovered( ) or self:GetDragging( ) ) ) then 
            Color.a = 35

            surface.SetFont( 'DefaultFixedDropShadow' )
            surface.SetTextColor( Color )
            surface.SetTextPos( W * Value + Coffee.Menu:Scale( 5 ), 2 ) 
            surface.DrawText( Coffee.Config[ Assignment ] .. ( Prefix or '' ) )
        end
    end

    Slider.Knob.Paint = function( self, W, H ) end

    -- Add the actual value feature.
    Slider.OnValueChanged = function( self, X, Y )
        Coffee.Config[ Assignment ] = math.Clamp( math.Round( Minimum + ( Maximum - Minimum ) * X, Decimals ), Minimum, Maximum )
    end

    return Slider
end