Coffee.Draggables.Bars = {
    Draggables = Coffee.Draggables,
    Ragebot    = Coffee.Ragebot,
    Client     = Coffee.Client,
    Config     = Coffee.Config,

    Initialized = { }
}

function Coffee.Draggables.Bars:Initialize( Panel, Assignment )
    Panel:SetVisible( self.Config[ Assignment ] )

    if ( self.Initialized[ Panel ] ) then 
        return self.Initialized[ Panel ]
    end

    local Height = 30
    local Bar    = 15

    Panel:SetTall( Height )
    Panel:DockPadding( 1, Bar, 1, 0 )

    local DProgress = vgui.Create( 'DProgress', Panel )
    DProgress:Dock( TOP )
    DProgress:DockMargin( 0, 0, 0, 0 )
    DProgress:SetTall( Height - Bar - 1 )
    DProgress.Paint = function( self, W, H )
        surface.SetMaterial( Coffee.Menu.Gradients.Center )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawTexturedRect( 0, 0, W * self:GetFraction( ), H )
    end

    self.Initialized[ Panel ] = DProgress

    return DProgress
end

function Coffee.Draggables.Bars:Update( Choke )
    local Choke = self.Draggables:Get( 'Choke', true )
    local LC    = self.Draggables:Get( 'Lag Compensation', true )

    -- Update choke.
    local Handle = self:Initialize( Choke, 'world_choke_indicator' )

    Handle:SetFraction( ( self.Ragebot.Choked or 0 ) / 24 )

    -- Update LC.
    Handle = self:Initialize( LC, 'world_lc_indicator' )

    if ( self.Client.Local ) then 
        Handle:SetFraction( math.min( self.Client.Distance / 4096, 1 ) )
    end
end