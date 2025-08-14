function Coffee.Visuals:HandleFont( Font )
    return self.Fonts[ Font ]
end

function Coffee.Visuals:HandleFillament( In, Max )
    return math.min( self.Position.H * In / Max, self.Position.H )
end

function Coffee.Visuals:RenderText( Text, Assignment, colorOverride, fontOverride )
    if ( not Coffee.Config[ Assignment ] ) then 
        return
    end

    -- Get config handle.
    local Dock, Font = Coffee.Config[ Assignment .. '_dock' ], fontOverride or Coffee.Config[ Assignment .. '_font' ]

    surface.SetFont( self:HandleFont( Font or 'Small' ) )
	surface.SetTextColor( colorOverride or Coffee.Config[ Assignment .. '_color' ] )
	surface.SetTextPos( self:HandleDock( Dock, Text ) ) 
	surface.DrawText( Text )
end

function Coffee.Visuals:RenderBar( Fillament, Color, Assignment )
    if ( not Coffee.Config[ Assignment ] ) then 
        return
    end

    local X, Y = self:HandleDock( Coffee.Config[ Assignment .. '_dock' ], '', 4 )

    -- Adjust to match the size of the 2D boxes.
    Y = Y + 2

    -- Render the bar background.
    surface.SetDrawColor( 0, 0, 0, 120 )
    surface.DrawRect( X, Y, 2, self.Position.H )

    -- Flip direction if needed.
    if ( Coffee.Config[ Assignment .. '_direction' ] ) then 
        Fillament = math.min( Fillament, self.Position.H ) 
    else
        Y = Y + ( self.Position.H - Fillament )
    end

    -- Get override options.
    local Override = Coffee.Config[ Assignment .. '_override' ]
    local Material = Coffee.Config[ Assignment .. '_override_material' ]

    -- Render the main healthbar element.
    if ( Override and Material == 'Gradient' ) then 
        surface.SetMaterial( self.Menu.Gradients.Up )
        surface.SetDrawColor( Coffee.Config[ Assignment .. '_override_up' ] )
        surface.DrawTexturedRect( X, Y, 2, Fillament )
        
        surface.SetMaterial( self.Menu.Gradients.Down )
        surface.SetDrawColor( Coffee.Config[ Assignment .. '_override_down' ] )
        surface.DrawTexturedRect( X, Y, 2, Fillament )
    else 
        if ( Override and Coffee.Config[ Assignment .. '_override_color' ] ) then 
            Color = Coffee.Config[ Assignment .. '_override_up' ] 
        end

        surface.SetDrawColor( Color )

        if ( Override ) then
            surface.SetMaterial( self.Materials:Get( Material, true, Color ) )
            surface.DrawTexturedRect( X, Y, 2, Fillament )
        else
            surface.DrawRect( X, Y, 2, Fillament )
        end
    end
end