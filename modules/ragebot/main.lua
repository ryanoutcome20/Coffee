Coffee.Ragebot = { 
    Records = Coffee.Records,
    Menu    = Coffee.Menu,
    Config  = Coffee.Config,
    Require = Coffee.Require,
    Client  = Coffee.Client,
    Shots   = Coffee.Shots,
    
    Bots    = Coffee.Bots,

    Hitboxes = {
        [ HITGROUP_GENERIC ] = 'aimbot_hitboxes_generic',
        [ HITGROUP_HEAD ] = 'aimbot_hitboxes_head',
        [ HITGROUP_CHEST ] = 'aimbot_hitboxes_chest',
        [ HITGROUP_STOMACH ] = 'aimbot_hitboxes_stomach',
        [ HITGROUP_LEFTARM ] = 'aimbot_hitboxes_arms',
        [ HITGROUP_RIGHTARM ] = 'aimbot_hitboxes_arms',
        [ HITGROUP_LEFTLEG ] = 'aimbot_hitboxes_feet',
        [ HITGROUP_RIGHTLEG ] = 'aimbot_hitboxes_feet'
    },

    Indexes = { },

    isManipulating = false,

    Yaw = GetConVar( 'm_yaw' ),
    Pitch = GetConVar( 'm_pitch' ),

    Silent = angle_zero
}

Coffee:LoadFile( 'lua/coffee/modules/ragebot/resolver/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/aimbot/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/antiaim/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/swcs.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/hl2.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/pack.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/targeter.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/silent.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/angles.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/hitbox_parser.lua' )

function Coffee.Ragebot:Update( CUserCMD )
    if ( not self.Client.Local ) then 
        return
    end

    self:SetPack( self.Client.Weapon )
    self:SetupSilent( CUserCMD )

    if ( CUserCMD:CommandNumber( ) == 0 ) then 
        return
    end

    self.Packet = true
    self.isManipulating = false

    -- Note that something needs to be done about this big prediction block.
    -- I have functions from other modules that require the movement fixes assistance.

    self.Require:StartPrediction( CUserCMD )
        self:Speedhack( CUserCMD )
        self:Lagswitch( CUserCMD )

        self:Fakelag( CUserCMD )    

        self:AntiAim( CUserCMD )

        self:Aimbot( CUserCMD )

        self:SetupMovement( CUserCMD )

        self.Bots:Update( CUserCMD )

        self:BreakAnimations( CUserCMD )
    self.Require:EndPrediction( )

    if ( not self.Packet ) then 
        self.Choked = self.Choked + 1
    else
        self.Choked = 0
    end
    
    self.Require:BSendPacket( self.Packet )
end

Coffee.Hooks:New( 'CreateMove', Coffee.Ragebot.Update, Coffee.Ragebot )