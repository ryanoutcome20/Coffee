function Coffee.Menu:GenerateTab( Name, Width, Height )
    -- Generate main tab panel.
    local Tab = vgui.Create( 'DFrame', self.Background )
    Tab:SetSize( Width, Height )
	Tab:Center( )
	Tab:SetTitle( '' )
	Tab:SetDraggable( true )
    Tab:ShowCloseButton( false )
	Tab:SetVisible( false )
    Tab:SetKeyboardInputEnabled( true )
    Tab:SetMouseInputEnabled( true )

    Tab.Paint = function( self, W, H )
        surface.SetDrawColor( 18, 18, 18 )
        surface.DrawRect( 0, 0, W, H )
        
        surface.SetMaterial( Coffee.Menu.Gradients.Uni )
        surface.SetDrawColor( 24, 24, 24 )
        surface.DrawTexturedRect( 0, 0, W, H )

        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawTexturedRect( 0, 0, W, 20 )

        surface.SetMaterial( Coffee.Menu.Gradients.Left )
        surface.SetDrawColor( 40, 40, 40 )
        surface.DrawTexturedRect( 0, 0, W, 20 )

        surface.SetFont( 'DefaultSmall' )
        surface.SetTextColor( Coffee.Menu.Color )
        surface.SetTextPos( 5, 4 ) 
        surface.DrawText( Name )
        
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    -- Generate handler for the sub colums.
    local Handler = vgui.Create( 'DIconLayout', Tab )
    Handler:Dock( FILL )
    Handler:SetStretchWidth( true )
    Handler:SetStretchHeight( true )
    Handler:SetSpaceX( 5 )

    -- Generate sub colum panels (left, right).
    local WW, HH = Width / 2 - self:Scale( 8 ), Height / 1.08 -- Yes, this is ugly; no, it is not my fault.

    local Left = self:GenerateTabSubPanel( Handler, WW, HH )
    local Right = self:GenerateTabSubPanel( Handler, WW, HH )

    Handler:Layout( )

    -- Assign tab for the later indexing.
    self.Tabs[ Name ] = {
        -- Main block.
        Parent = Tab,

        -- Subpanels.
        Handler = Handler,
        Left    = Left,
        Right   = Right,

        -- Scrollpanels.
        LeftS  = self:GenerateScrollBar( Left ),
        RightS = self:GenerateScrollBar( Right ),
    }
end

function Coffee.Menu:GenerateTabSubPanel( Panel, W, H )
    -- Have to generate the two left and right panels within every tab.

    local Side = vgui.Create( 'DPanel', Panel )
    Side:SetSize( W, H )
    Side.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 120 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    return Side
end

function Coffee.Menu:GenerateScrollBar( Panel )
    -- Have to generate the scrollbar for the inside of tabs (left and right colum) such that
    -- they'll fit our elements that we plan to put in them.

    -- Generate main panel.
    local Scroll = vgui.Create( 'DScrollPanel', Panel )
    Scroll:Dock( FILL )
    Scroll:DockMargin( self:Scale( 6 ), self:Scale( 6 ), self:Scale( 6 ), self:Scale( 6 ) )

    -- Edit our sidebar.
    local Bar = Scroll:GetVBar(  )
    Bar:SetWide( self:Scale( 6 ) )
    Bar:SetHideButtons( true )

    Bar.Paint = function( self, W, H )
        surface.SetDrawColor( 18, 18, 18 )
        surface.DrawRect( 0, 0, W, H )
    end

    Bar.btnGrip.Paint = function( self, W, H )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawRect( 0, 0, W, H )
    end
    
    return Scroll
end