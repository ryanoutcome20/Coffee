Coffee.Client = { }

function Coffee.Client:Update( )
    self.Local      = self.Local or Coffee.Localplayer
    self.Prediction = self.Prediction or 0
    self.LC         = self.LC or false

    if ( self.Origin ) then 
        self.LC = self.Origin:DistToSqr( self.Local:GetNetworkOrigin( ) ) > 4096
    end

    self.Health = self.Local:Health( )
    self.Alive  = self.Local:Alive( ) and self.Local:Health( ) > 0  
    
    self.EyePos = self.Local:EyePos( )
    self.EyeAngles = self.Local:EyeAngles( )
    
    self.Origin = self.Local:GetNetworkOrigin( )
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