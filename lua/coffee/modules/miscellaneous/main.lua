Coffee.Miscellaneous = { 
	Require = Coffee.Require,
    Client  = Coffee.Client
}

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/bots/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/movement/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/chat/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/config/handler.lua' )

function Coffee.Miscellaneous:Update( Stage, CUserCMD )
    if ( Stage != MOVE_PREDICTED ) then 
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

    self:QuickMovement( CUserCMD )
	
	if ( Coffee.Config[ 'miscellaneous_disconnect_reason' ] ) then
		self.Require:SetDisconnectReason( Coffee.Config[ 'miscellaneous_disconnect_reason_text' ] )
	end
end

Coffee.Hooks:New( 'CMC', Coffee.Miscellaneous.Update, Coffee.Miscellaneous )