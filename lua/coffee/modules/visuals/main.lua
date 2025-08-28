Coffee.Visuals = { 
    Records    = Coffee.Records,
    Menu       = Coffee.Menu,
    Config     = Coffee.Config,
    Client     = Coffee.Client,
    Colors     = Coffee.Colors,
    Notify     = Coffee.Notify,
    Resolution = Coffee.Resolution,
	Playerlist = Coffee.Playerlist,
    Materials  = Coffee.Materials,
    Ragebot    = Coffee.Ragebot,
    Overlay    = Coffee.Overlay,
    CSEntity   = Coffee.CSEntity,
    Hitmarker  = Coffee.Hitmarker,
    Gamemodes  = Coffee.Gamemodes,
    Gamemode   = Coffee.Gamemode,
    Items      = Coffee.Items,

    Fonts = {
        [ 'Icons' ] = 'coffee-icons',
        [ 'Main' ]  = 'coffee-main',
        [ 'Small' ] = 'coffee-small'
    },

    Effects = {
        [ 'Tesla' ]        = 'TeslaHitboxes',
        [ 'Gibs' ]         = 'AntlionGib',
        [ 'Sparks' ]       = 'ElectricSpark',
        [ 'Heavy Sparks' ] = 'Sparks',
        [ 'Explosion' ]    = 'Explosion',
        [ 'Vortigaunt' ]   = 'VortDispel'
    },

	FOV = GetConVar( 'fov_desired' ),

    Fade = { },
    Offsets = { }
}

if _SCF then
	surface.CreateFont = _SCF
end

surface.CreateFont( 'coffee-main', {
   font = 'Verdana',
   extended = false,
   size = 12, 
   weight = 700,
   antialias = false,
   shadow = true,
   outline = false
} )

surface.CreateFont( 'coffee-icons', {
    font = 'HalfLife2',
    extended = true,
    size = 18, 
    weight = 900,
    antialias = true,
    shadow = true,
    outline = false
} )

surface.CreateFont( 'coffee-small', {
    font = 'Consolas',
    extended = false,
    size = 12, 
    weight = 500,
    antialias = false,
    shadow = true,
    outline = false
} )

Coffee:LoadFile( 'lua/coffee/modules/visuals/animations/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/draggables/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/chams/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/world/footsteps.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/modulate.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/impacts.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/view.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/sky.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/weather.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/anonymizer.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/world/announcer.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/icons.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/indicators.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/items.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/glow.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/dock.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/renderer.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/handler.lua' )

function Coffee.Visuals:Update( )
    -- We shouldn't run if we haven't even had the time for a FrameStageNotify yet.
    if ( not self.Client.Local ) then 
        return
    end
    
    self:Watermark( )
    self:Notifications( )
    self:Wallhack( )
    self:Entities( )
	self:FOVCircle( )
end

function Coffee.Visuals:Update3D( ) 
    if ( not self.Client.Local ) then 
        return
    end

    cam.Start3D( )
        self:PlayerChams( )
        self:FakeChams( )
    cam.End3D( )

    self.Sky:Handler( )
end

Coffee.Hooks:New( 'RenderScreenspaceEffects', Coffee.Visuals.Update3D, Coffee.Visuals )
Coffee.Hooks:New( 'HUDPaint', Coffee.Visuals.Update, Coffee.Visuals )