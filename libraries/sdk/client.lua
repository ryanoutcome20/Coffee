Coffee.Client = { }

function Coffee.Client:Update( )
    self.Local = self.Local or Coffee.Localplayer

    self.Health = self.Local:Health( )
    self.Alive  = self.Local:Alive( ) and self.Local:Health( ) > 0  
    
    self.Team   = self.Local:Team( )
end

Coffee.Hooks:New( Coffee.Require:FrameStageNotify( ), Coffee.Client.Update, Coffee.Client )