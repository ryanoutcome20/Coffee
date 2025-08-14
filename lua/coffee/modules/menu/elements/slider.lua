function Coffee.Menu:GenerateSlider( Panel, Assignment, Minimum, Maximum, Default, Decimals, noLabel, Prefix )
    -- Have to generate the sliders used throughout the menu.

    -- Set our default.
    Coffee.Config[ Assignment ] = Default

    -- Generate the main slider.
    local Slider = vgui.Create( 'DSlider', Panel or self.Last )    
    Slider:SetSize( self:Scale( 100 ), 15 )
    Slider:Dock( RIGHT )
    Slider:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
    Slider:SetSlideX( ( Default - Minimum ) / ( Maximum - Minimum ) )

    -- Add some paint to this empty slider.
    Slider.Paint = function( self, W, H )
        -- Get value.
        local Value = ( ( Coffee.Config[ Assignment ] - Minimum ) / ( Maximum - Minimum ) )

        -- Render overlay.
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
            
        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.DrawTexturedRect( 0, 0, W * Value, H )
    
        -- Render label.
        if ( not noLabel and ( self:IsHovered( ) or self:IsChildHovered( ) or self:GetDragging( ) ) ) then 
            local Text = Coffee.Config[ Assignment ] .. ( Prefix or '' )
            local Width = W * Value + 5

            surface.SetFont( 'DefaultFixedDropShadow' )
            surface.SetTextColor( Coffee.Menu.Colors.White )

            local TW, TH = surface.GetTextSize( Text )

            surface.SetTextPos( math.Clamp( Width, 0, W - TW - 3 ), 2 ) 
            surface.DrawText( Text )
        end
    end

    Slider.Think = function( self )
		local X = ( ( Coffee.Config[ Assignment ] - Minimum ) / ( Maximum - Minimum ) )
		
		if ( not self:GetDragging( ) and ( self:IsHovered( ) or self:IsChildHovered( ) ) ) then 
			local Update = false
	
            if ( input.IsKeyDown( KEY_LEFT ) ) then 
                X = X - math.max( 1 / Maximum, 0.0001 )
				Update = not Update
            end
			
			if ( input.IsKeyDown( KEY_RIGHT ) ) then
                X = X + math.max( 1 / Maximum, 0.0001 )
				Update = not Update
            end

			if Update then
				self:OnValueChanged( X, self.m_fSlideY )
			end
        end
		
		self:SetSlideX( X )
    end

    Slider.Knob.Paint = function( self, W, H ) end

    -- Add the actual value feature.
    Slider.OnValueChanged = function( self, X, Y )
        Coffee.Config[ Assignment ] = math.Clamp( math.Round( Minimum + ( Maximum - Minimum ) * X, Decimals ), Minimum, Maximum )
    end

    return Slider
end