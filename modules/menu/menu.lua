Coffee.Menu = { 
    Resolution = Coffee.Resolution,
    Colors     = Coffee.Colors,

    Gradients = {
        Up    = Material( 'vgui/gradient_up' ),
        Down  = Material( 'vgui/gradient_down' ),
        Left  = Material( 'vgui/gradient-l' ),
        Right = Material( 'vgui/gradient-r' ),
        Uni   = Material( 'vgui/gradient-u' ),
        Grid  = Material( 'gui/alpha_grid.png', 'nocull' )
    },

    Color  = Coffee.Colors[ 'Main Light' ],
    Copied = Coffee.Colors[ 'Main' ],

    Background = NULL,
    Bottom     = NULL,
    Active     = NULL,
    Last       = NULL,
    
    Tabs    = { },
    Toggles = { },

    Held = false
}

Coffee:LoadFile( 'lua/coffee/modules/menu/elements/tabs.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/label.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/slider.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/button.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/binder.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/checkbox.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/dropdown.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/colorpicker.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/elements/minicheckbox.lua' )

function Coffee.Menu:Scale( Size )
    return math.max( Size * ( self.Resolution.Height / 1080 ), 1 )
end

function Coffee.Menu:Init( Tabs )
    if ( not istable( Tabs ) ) then 
        return Coffee:Print( true, 'Invalid tab layout passed to menu initializer "%s"!', type( Tabs ) )
    end

    local Offset = self:Scale( 50 )

    -- Generate the background.
    local Background = vgui.Create( 'DPanel' )
    Background:SetSize( self.Resolution.Width, self.Resolution.Height )
    Background:SetKeyboardInputEnabled( true )
    Background.Paint = function( self, W, H )
        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawRect( 0, 0, W, H )
    end

    self.Background = Background

    -- Generate the bottom tab selector.
    local Bottom = vgui.Create( 'DFrame', Background )
	Bottom:SetSize( self.Resolution.Width, Offset )
	Bottom:SetPos( 0, self.Resolution.Height - ( Offset / 2 ) )
	Bottom:SetTitle( '' )
	Bottom:SetDraggable( false )
    Bottom:ShowCloseButton( false )
    Bottom:MakePopup( )

    Bottom.Paint = function( self, W, H )
        surface.SetMaterial( Coffee.Menu.Gradients.Up )
        surface.SetDrawColor( 12, 12, 12 )
        surface.DrawTexturedRect( 0, 0, W, H )
    
        surface.SetMaterial( Coffee.Menu.Gradients.Down )
        surface.SetDrawColor( 24, 24, 24 )
        surface.DrawTexturedRect( 0, 0, W, H )

        surface.SetDrawColor( 0, 0, 0, 150 )
        surface.DrawRect( 0, 0, W, H )

        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawOutlinedRect( -4, 0, W + 8, H, 2 )
    end

    self.Bottom = Bottom
    
    -- Generate our tabs.
    for i = 0, #Tabs - 1 do 
        local Index = Tabs[ i + 1 ]

        self:GenerateTab( Index.Title, self:Scale( 600 ), self:Scale( Index.Height ) )

        local TabButton = vgui.Create( 'DButton', Bottom )
        TabButton:SetText( Index.Title )
        TabButton:SetTextColor( self.Colors[ 'White' ] )
        TabButton:SetFont( 'Default' )
        TabButton:SizeToContents( )
        TabButton:Dock( LEFT )
        TabButton:DockMargin( 0, -self:Scale( 50 ), self:Scale( 5 ), 0 )
        
        TabButton.Paint = function( self, W, H ) 
            self:SetColor( Coffee.Menu.Color )    
        end

        TabButton.DoClick = function( self, W, H )
            Coffee.Menu.Tabs[ Index.Title ].Parent:ToggleVisible( )
        end
    end

    -- Generate the timestamp.
    local Timestamp = vgui.Create( 'DLabel', Bottom )
    Timestamp:Dock( RIGHT )
    Timestamp:DockMargin( 0, -self:Scale( 50 ), -self:Scale( 15 ), 0 )
    Timestamp:SetText( '' )
    
    Timestamp.Paint = function( self, W, H ) 
        self:SetColor( Coffee.Menu.Color )    
    end
    
    Timestamp.Think = function( self )
        self:SetText( os.date( '%X' ) )
    end
end

function Coffee.Menu:Handle( Title, Callback, Side )
    local Tab = self.Tabs[ Title ]

    if ( not Tab ) then 
        return
    end

    Callback( self, Side and Tab.RightS or Tab.LeftS )
end

function Coffee.Menu:Input( )
    if ( input.IsKeyDown( KEY_INSERT ) ) then 
        if ( not self.Toggle ) then 
            self.Background:ToggleVisible( )
        end
        
        self.Toggle = true
    else 
        self.Toggle = false
    end
end

Coffee.Menu:Init( {
    { Title = 'Aimbot', Height = 500 },
    { Title = 'Anti-Aim', Height = 500 },
    { Title = 'Players', Height = 500 },
    { Title = 'World', Height = 500 },
    { Title = 'Miscellaneous', Height = 500 },
} )

Coffee.Hooks:New( 'Think', Coffee.Menu.Input, Coffee.Menu )