function Coffee.Menu:GenerateTab( Name, Width, Height, Single )
    -- Generate main tab panel.
    local Tab = vgui.Create( 'DFrame' )
    Tab:SetSize( Width, Height )
	Tab:Center( )
	Tab:SetTitle( '' )
	Tab:SetDraggable( true )
    Tab:ShowCloseButton( false )
    Tab:SetKeyboardInputEnabled( true )
    Tab:SetMouseInputEnabled( true )
    Tab:MakePopup( )
	Tab:SetVisible( false )

    Tab.Paint = function( self, W, H )
        surface.SetDrawColor( 18, 18, 18 )
        surface.DrawRect( 0, 0, W, H )
        
        surface.SetMaterial( Coffee.Menu.Gradients.Uni )
        surface.SetDrawColor( 24, 24, 24 )
        surface.DrawTexturedRect( 0, 0, W, H )

        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawTexturedRect( 0, 0, W, 20 )
        
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )

        if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
            surface.SetTextColor( Coffee.Menu.Color )
        else
            surface.SetTextColor( Coffee.Colors[ 'White' ] )
        end

        surface.SetFont( 'DefaultSmall' )
        surface.SetTextPos( 5, 4 ) 
        surface.DrawText( Name )
    end

    if ( not Single ) then 
        -- Generate handler for the sub columns.
        local Handler = vgui.Create( 'DIconLayout', Tab )
        Handler:Dock( FILL )
        Handler:SetStretchWidth( true )
        Handler:SetStretchHeight( true )
        Handler:SetSpaceX( 5 )

        -- Generate sub column panels (left, right).
        local WW, HH = Width / 2 - 8, Height / 1.08 -- Yes, this is ugly; no, it is not my fault.

        -- Should we be using DHorizontalDivider here?
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

        return
    end

    -- Generate our tab.
    local Handler = vgui.Create( 'DPanel', Tab )
    Handler:Dock( FILL )
    Handler.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 120 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( 0, 0, W, H, 1 )
    end

    -- Assign tab for the later indexing.
    self.Tabs[ Name ] = {
        -- Main block.
        Parent = Tab,

        -- Subpanels.
        Handler = Handler,
        Left    = Handler,
        Right   = Handler,

        -- Scrollpanels.
        LeftS  = Handler,
        RightS = Handler,
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
    -- Have to generate the scrollbar for the inside of tabs (left and right column) such that
    -- they'll fit our elements that we plan to put in them.

    -- Generate main panel.
    local Scroll = vgui.Create( 'DScrollPanel', Panel )
    Scroll:Dock( FILL )
    Scroll:DockMargin( self:Scale( 6 ), self:Scale( 6 ), self:Scale( 6 ), self:Scale( 6 ) )
    Scroll:SetMouseInputEnabled( true )
    Scroll:SetKeyboardInputEnabled( true )

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