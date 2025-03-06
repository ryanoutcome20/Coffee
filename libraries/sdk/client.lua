Coffee.Client = { 
    Overlay = Coffee.Overlay,
    Config  = Coffee.Config
}

function Coffee.Client:Update( )
    self.Local      = self.Local or Coffee.Localplayer
    self.Prediction = self.Prediction or 0
    self.LC         = self.LC or false

    local Origin = self.Local:GetNetworkOrigin( )

    if ( self.Config[ 'world_update_dot' ] ) then 
        local Z   = Vector( 0, 0, 3 )

        self.Overlay:Box( Origin + Z, nil, nil, false, self.Config[ 'world_update_dot_current' ] )

        if ( not self.Config[ 'world_update_dot_choked' ] or ( Coffee.Ragebot and not Coffee.Ragebot.Packet ) ) then
            self.Overlay:Box( self.Origin + Z, nil, nil, false, self.Config[ 'world_update_dot_previous' ] )
        end

        if ( self.Config[ 'world_update_line' ] ) then 
            self.Overlay:Line( Origin + Z, self.Origin + Z, false, self.Config[ 'world_update_line_color' ] )
        end
    end

    if ( self.Origin ) then 
        self.LC = self.Origin:DistToSqr( Origin ) > 4096
    end

    self.Health = self.Local:Health( )
    self.Alive  = self.Local:Alive( ) and self.Local:Health( ) > 0  
    
    self.EyePos = self.Local:EyePos( )
    self.EyeAngles = self.Local:EyeAngles( )

    self.Maxs = self.Local:OBBMaxs( )
    self.Mins = self.Local:OBBMins( )
    self.Step = self.Local:GetStepSize( )

    self.Origin = Origin
    self.Velocity = self.Local:GetVelocity( )
    self.Speed = self.Velocity:Length2D( )

    self.Team   = self.Local:Team( )

    self.Position = self.Local:GetPos( )
    self.Movetype = self.Local:GetMoveType( )

    self.Tickbase = self.Local:GetInternalVariable( 'm_nTickBase' )
    
    self.Ping = self.Local:Ping( )

    self.Weapon = self.Local:GetActiveWeapon( )
end

function Coffee.Client:GetPredictionTime( )
    if ( IsFirstTimePredicted( ) ) then
        -- This isn't technically a "bullet time"; more or less, this is the last
        -- time you were predicted.
        self.Prediction = CurTime( ) + engine.TickInterval( ) 
    end
end

Coffee.Hooks:New( Coffee.Require:FrameStageNotify( ), Coffee.Client.Update, Coffee.Client )
Coffee.Hooks:New( 'Move', Coffee.Client.GetPredictionTime, Coffee.Client )