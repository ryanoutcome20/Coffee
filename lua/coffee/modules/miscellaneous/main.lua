Coffee.Miscellaneous = { 
    Config = Coffee.Config,
    Client = Coffee.Client
}

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/bots/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/movement/handler.lua' )

function Coffee.Miscellaneous:Update( Stage, CUserCMD )
    if ( Stage != MOVE_POST_MOVEMENT ) then 
        return
    end

    if ( not self.Client.Local or not self.Client.Alive ) then 
        return
    end
    
    if ( self.Client.Movetype == MOVETYPE_NOCLIP or self.Client.Movetype == MOVETYPE_LADDER ) then 
        return
    end

    self:Autostrafe( CUserCMD )
    self:Bunnyhop( CUserCMD )
end

Coffee.Hooks:New( 'CreateMoveEx', Coffee.Miscellaneous.Update, Coffee.Miscellaneous )