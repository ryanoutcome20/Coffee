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

    local usingPrediction = Coffee.Config[ 'aimbot_engine' ] and Coffee.Config[ 'aimbot_engine_constant' ]

    for Stage = 0, MOVE_END do 
        if ( usingPrediction and Stage == MOVE_POST_PREDICTED ) then 
            self.Require:EndPrediction( CUserCMD )
        end

        self.Hooks:Call( 'CMC', Stage, CUserCMD )

        if ( usingPrediction and Stage == MOVE_PRE_PREDICTED ) then 
            self.Require:StartPrediction( CUserCMD )
        end
    end
end

Coffee.Hooks:New( 'CreateMove', Coffee.CreateMove.CreateMove, Coffee.CreateMove )