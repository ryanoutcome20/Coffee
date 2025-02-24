Coffee.Ragebot = { 
    Records = Coffee.Records,
    Menu    = Coffee.Menu,
    Config  = Coffee.Config,
    Client  = Coffee.Client,

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

    inPrediction = false,

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

    ded.StartPrediction( CUserCMD )
        self:AntiAim( CUserCMD )

        self:Aimbot( CUserCMD )

        self:SetupMovement( CUserCMD )
    ded.FinishPrediction( )
end

Coffee.Hooks:New( 'CreateMove', Coffee.Ragebot.Update, Coffee.Ragebot )