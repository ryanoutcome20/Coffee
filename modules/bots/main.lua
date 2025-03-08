Coffee.Bots = { 
    Client = Coffee.Client
}

Coffee:LoadFile( 'lua/coffee/modules/bots/point/handler.lua' )
Coffee:LoadFile( 'lua/coffee/modules/bots/simple/handler.lua' )

function Coffee.Bots:Update( CUserCMD )
    if ( self.Client.Movetype == MOVETYPE_NOCLIP or self.Client.Movetype == MOVETYPE_LADDER ) then 
        return
    end
    
    if ( CUserCMD:KeyDown( IN_ATTACK ) or CUserCMD:KeyDown( IN_USE ) ) then 
        return
    end
    
    self.Simple:Simple( CUserCMD )
    self.Point:Point( CUserCMD )
end