Coffee.Ragebot = { 
    Optimizations = Coffee.Optimizations,
    Records       = Coffee.Records,
    Require       = Coffee.Require,
    Overlay       = Coffee.Overlay,
    Config        = Coffee.Config,
    Client        = Coffee.Client,
    Shots         = Coffee.Shots,
    Menu          = Coffee.Menu,
    
    Bots = Coffee.Bots,

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
    Cones   = { },

    isManipulating = false,

    Yaw = GetConVar( 'm_yaw' ),
    Pitch = GetConVar( 'm_pitch' ),

    Fake   = angle_zero,
    Real   = angle_zero,
    Silent = angle_zero
}

Coffee:LoadFile( 'lua/coffee/modules/ragebot/resolver/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/aimbot/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/antiaim/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/hl2.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/m9k.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/swcs.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/packs/tfa.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/pack.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/silent.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/angles.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/targeter.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/grenades.lua' )
Coffee:LoadFile( 'lua/coffee/modules/ragebot/helpers/hitbox_parser.lua' )

function Coffee.Ragebot:PrePredicted( Stage, CUserCMD )
    if ( Stage != MOVE_PRE_PREDICTED ) then 
        return
    end

    if ( not self.Client.Local ) then 
        return
    end

    self:SetPack( self.Client.Weapon )
    self:SetupSilent( CUserCMD )
    
    self.Records:Cleanup( )

    if ( CUserCMD:CommandNumber( ) == 0 ) then 
        return
    end

    self.Packet = true
    self.isManipulating = false
    self.currentAngle = false
end

function Coffee.Ragebot:Predicted( Stage, CUserCMD )
    if ( Stage != MOVE_PREDICTED ) then 
        return
    end

    if ( CUserCMD:CommandNumber( ) == 0 ) then 
        return
    end

    self:Speedhack( CUserCMD )
    self:Lagswitch( CUserCMD )
    self:Networking( CUserCMD )

    self:AntiAim( CUserCMD )

    self:Fakelag( CUserCMD )

    self:Aimbot( CUserCMD )

    self:AdjustGrenades( CUserCMD )

    self:SetupMovement( CUserCMD )

    self:BreakAnimations( CUserCMD )
    
    if ( not self.Packet ) then 
        self.Choked = self.Choked + 1
    else
        self.Choked = 0
    end
    
    self.Require:BSendPacket( self.Packet )
end

Coffee.Hooks:New( 'CreateMoveEx', Coffee.Ragebot.Predicted, Coffee.Ragebot )
Coffee.Hooks:New( 'CreateMoveEx', Coffee.Ragebot.PrePredicted, Coffee.Ragebot )