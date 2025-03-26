Coffee.CreateMove = { 
    Require = Coffee.Require,
    Config  = Coffee.Config,
    Client  = Coffee.Client,
    Hooks   = Coffee.Hooks
}

function Coffee.CreateMove:CreateMove( CUserCMD )
    if ( not self.Client.Local ) then 
        return
    end

    local usingPrediction = self.Config[ 'aimbot_engine' ]

    for Stage = 0, MOVE_END do 
        if ( usingPrediction and Stage == MOVE_POST_PREDICTED ) then 
            self.Require:EndPrediction( )
        end

        self.Hooks:Call( 'CreateMoveEx', Stage, CUserCMD )

        if ( usingPrediction and Stage == MOVE_PRE_PREDICTED ) then 
            self.Require:StartPrediction( CUserCMD )
        end
    end
end

Coffee.Hooks:New( 'CreateMove', Coffee.CreateMove.CreateMove, Coffee.CreateMove )