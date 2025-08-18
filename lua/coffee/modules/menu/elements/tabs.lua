function Coffee.Menu:GenerateTab( Name, Width, Height, Single )
    -- Generate main tab panel.
    local Tab = vgui.Create( 'DFrame' )
    Tab:SetSize( Width, Height )
	Tab:Center( )
	Tab:SetTitle( '' )
	Tab:SetDraggable( true )
    Tab:SetSizable( true )
    Tab:ShowCloseButton( false )
    Tab:SetKeyboardInputEnabled( true )
    Tab:SetMouseInputEnabled( true )
    Tab:MakePopup( )
	Tab:SetVisible( false )

    Tab:SetMinWidth( Width )
    Tab:SetMinHeight( Height )

    Tab.Paint = function( self, W, H )
        if ( self:GetAlpha( ) == 255 ) then 
            draw.RoundedBoxEx( 8, 0, 0, W, H, Coffee.Menu.Color, false, false, true, true )
        end

        draw.RoundedBoxEx( 8, 1, 1, W - 2, H - 2, Coffee.Menu.Colors[ 'Dark Gray' ], false, false, true, true )

        surface.SetMaterial( Coffee.Menu.Gradients.Right )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawTexturedRect( 0, 0, W, 20 )

        if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
            surface.SetTextColor( Coffee.Menu.Color )
        else
            surface.SetTextColor( Coffee.Colors[ 'White' ] )
        end

        surface.SetFont( 'DefaultSmall' )
        surface.SetTextPos( 5, 4 ) 
        surface.DrawText( Name )
    end
    
    -- local Button = vgui.Create( 'DImageButton', Tab )
    -- Button:SetImage( 'icon16/cup.png' )
    -- Button:SizeToContents( )
    -- Button:SetColor( Color( 17, 17, 17, 240 ) )
    -- Button:SetDepressImage( false )

    -- Button.Think = function( self, W, H )
    --     local WW, HH = self:GetParent( ):GetSize( )

    --     Button:SetPos( WW - 20, 2 )
    -- end

    if ( not Single ) then 
        -- Generate handler for the sub columns.
        local Handler = vgui.Create( 'DHorizontalDivider', Tab )
        Handler:Dock( FILL )

        Handler:InvalidateParent( true )

        -- Generate sub column panels (left, right).
        local Left  = self:GenerateTabSubPanel( Handler )
        local Right = self:GenerateTabSubPanel( Handler )

        -- Setup our handler with our left and right panels.
        Handler:SetLeft( Left )
        Handler:SetRight( Right )
        
        -- Dynamically resize our sub panels so we can have a resizable menu.
        Handler.Paint = function( self, W, H )
            local WW = W / 2
    
            Handler:SetDividerWidth( 2 )
            Handler:SetLeftMin( WW - 2 )
            Handler:SetRightMin( WW )
            Handler:SetLeftWidth( WW )
        end

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
	Handler:DockPadding( 4, 4, 4, 4 )
    Handler.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 255 )
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

function Coffee.Menu:GenerateTabSubPanel( Panel )
    -- Have to generate the two left and right panels within every tab.

    local Side = vgui.Create( 'DPanel', Panel )
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
    local Bar = Scroll:GetVBar( )
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