Coffee.Client = { 
    Overlay = Coffee.Overlay,
    Update  = Coffee.Update,
    Config  = Coffee.Config,
    Fullupdate = Coffee.Fullupdate
}

function Coffee.Client:Update( )
    if ( self.Fullupdate:IsUpdating( ) ) then 
        return
    end

    self.Local      = self.Local or Coffee.Localplayer
    self.Prediction = self.Prediction or 0
    self.LC         = self.LC or false

    local Origin = self.Local:GetNetworkOrigin( )

    if ( self.Config[ 'world_update' ] ) then 
        local Z    = Vector( 0, 0, 3 )
        local Time = engine.TickInterval( )

        self.Overlay:Box( self.Origin + Z, nil, nil, Time, self.Config[ 'world_update_current_color' ] )
        self.Overlay:Line( Origin + Z, self.Origin + Z, Time, self.Config[ 'world_update_line_color' ] )
    end

    if ( self.Origin ) then 
        self.Distance = self.Origin:DistToSqr( Origin )
    end

    self.Health = self.Local:Health( )
    self.Alive  = self.Local:Alive( ) and self.Local:Health( ) > 0  
    
    self.EyePos = self.Local:EyePos( )
    self.EyeAngles = self.Local:EyeAngles( )

    self.Model = self.Local:GetModel( )
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

    if ( Coffee.Ragebot ) then 
        Coffee.Ragebot:UpdateFakeYaw( )
    end
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