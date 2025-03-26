function Coffee.Menu:GenerateMiniCheckbox( Panel, Tooltip, Assignment )
    -- Have to generate the small checkboxes next to main menu elements.

    Panel = Panel or self.Last

    -- Generate main checkbox handler.
    local Checkbox = vgui.Create( 'DCheckBox', Panel )
	Checkbox:Dock( RIGHT )
    Checkbox:DockMargin( self:Scale( 5 ), 0, self:Scale( 4 ), 0 )
	Checkbox:SetValue( Coffee.Config[ Assignment ] )

    Checkbox.OnChange = function( self, Value )
        Coffee.Config[ Assignment ] = Value
    end

    -- Setup our hover think.
    -- Can't use tooltips since the engine handles most of it and trying to paint over it
    -- will be overriden with the engines yellow color scheme.
    Checkbox.Hover, Checkbox.Timer = self:GenerateMiniCheckboxTooltip( Panel, Tooltip ), CurTime( )

    Checkbox.Paint = function( self, W, H )
        surface.SetDrawColor( Coffee.Config[ Assignment ] and Coffee.Menu.Color or Coffee.Menu.Colors[ 'Dark Gray' ] )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        if ( self:IsHovered( ) or self:IsChildHovered( ) ) then 
            if ( self.Timer + 0.3 < CurTime( ) ) then 
                self.Hover:SetVisible( true )
                self.Hover:MakePopup( )
                
                self.Hover:SetPos( gui.MouseX( ), gui.MouseY( ) - Coffee.Menu:Scale( 25 ) )
            end
        else             
            self.Timer = CurTime( )

            self.Hover:SetVisible( false ) 
        end
    end
end

function Coffee.Menu:GenerateMiniCheckboxTooltip( Panel, Tooltip )
    local Frame = vgui.Create( 'DPanel', Panel )
    Frame:SetSize( self:Scale( 80 ), self:Scale( 20 ) )
    Frame:MakePopup( )
    Frame:SetVisible( false )

    Frame.Paint = function( self, W, H ) 
        surface.SetDrawColor( 20, 20, 20, 200 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        surface.SetFont( 'DefaultSmall' )
        surface.SetTextColor( Coffee.Menu.Color )
        surface.SetTextPos( 2, 2 ) 
        surface.DrawText( Tooltip )

        -- There is a natural 1,1 offset of drawn text. Therefore three here is correct. We'll use five
        -- for some extra padding.
        self:SetWide( surface.GetTextSize( Tooltip ) + 5 )
    end

    return Frame
end