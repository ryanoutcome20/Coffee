Coffee.Visuals = { 
    Records = Coffee.Records,
    Menu    = Coffee.Menu,
    Config  = Coffee.Config,
    Client  = Coffee.Client,
    Materials = Coffee.Materials,

    Fade = { },
    Offsets = { }
}

surface.CreateFont( 'coffee-main', {
   font = 'Verdana',
   extended = false,
   size = 12, 
   weight = 700,
   antialias = false,
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

Coffee:LoadFile( 'lua/coffee/modules/visuals/chams/handler.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/glow.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/dock.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/renderer.lua' )
Coffee:LoadFile( 'lua/coffee/modules/visuals/wallhack/handler.lua' )

function Coffee.Visuals:Update( )
    -- We shouldn't run if we haven't even had the time for a FrameStageNotify yet.
    if ( not self.Client.Local ) then 
        return
    end
    
    self:Wallhack( )
end

function Coffee.Visuals:Update3D( ) 
    if ( not self.Client.Local ) then 
        return
    end

    cam.Start3D( )
        self:PlayerChams( )
    cam.End3D( )
end

Coffee.Hooks:New( 'RenderScreenspaceEffects', Coffee.Visuals.Update3D, Coffee.Visuals )
Coffee.Hooks:New( 'DrawOverlay', Coffee.Visuals.Update, Coffee.Visuals )