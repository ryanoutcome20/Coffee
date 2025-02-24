Coffee.Client = { }

function Coffee.Client:Update( )
    self.Local = self.Local or Coffee.Localplayer
    self.Prediction = self.Prediction or 0

    self.Health = self.Local:Health( )
    self.Alive  = self.Local:Alive( ) and self.Local:Health( ) > 0  
    
    self.EyePos = self.Local:EyePos( )
    self.EyeAngles = self.Local:EyeAngles( )

    self.Team   = self.Local:Team( )

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