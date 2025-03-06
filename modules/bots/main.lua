Coffee.Bots = {
    Overlay = Coffee.Overlay,
    Client = Coffee.Client,
    Config = Coffee.Config,
    Colors = Coffee.Colors,
    Menu   = Coffee.Menu,

    Active = 0,
    Points = { }
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
    
    self:Simple( CUserCMD )
    self:Point( CUserCMD )
end