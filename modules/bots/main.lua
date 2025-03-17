Coffee.Bots = { 
    Client = Coffee.Client
}

Coffee:LoadFile( 'lua/coffee/modules/bots/spawnbots/handler.lua' )
Coffee:LoadFile( 'lua/coffee/modules/bots/other/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/bots/walkbots/point/handler.lua' )
Coffee:LoadFile( 'lua/coffee/modules/bots/walkbots/simple/handler.lua' )

function Coffee.Bots:Update( CUserCMD )
    if ( not self.Client.Local or not self.Client.Alive ) then 
        return
    end

    self.Spawnbot:Handler( CUserCMD )
    self.Otherbot:Handler( CUserCMD )

    if ( self.Client.Movetype == MOVETYPE_NOCLIP or self.Client.Movetype == MOVETYPE_LADDER ) then 
        return
    end
    
    if ( CUserCMD:KeyDown( IN_ATTACK ) or CUserCMD:KeyDown( IN_USE ) ) then 
        return
    end
    
    self.Simple:Handler( CUserCMD )
    self.Point:Handler( CUserCMD )
end