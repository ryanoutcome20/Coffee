-- =============================================================================
-- Setup constants.
-- =============================================================================

local Coffee = { }

Coffee.Colors = { 
    [ 'Main' ]       = Color( 179, 156, 149 ), 

    [ 'White' ]     = Color( 255, 255, 255 ),
    [ 'Black' ]     = Color( 0, 0, 0 ),
    [ 'Gray' ]      = Color( 30, 30, 30 ),
    [ 'Invisible' ] = Color( 0, 0, 0, 0 ),

    [ 'Light Gray' ] = Color( 80, 80, 80 ),
    [ 'Dark Gray' ]  = Color( 18, 18, 18 ),
    [ 'Cyan' ]       = Color( 60, 180, 225 ),
    [ 'Purple' ]     = Color( 133, 97, 136 ),

    [ 'Red' ]   = Color( 255, 0, 0 ),
    [ 'Green' ] = Color( 0, 255, 0 ),
    [ 'Blue' ]  = Color( 0, 0, 255 )
}

Coffee.Localplayer = LocalPlayer( )

Coffee.Resolution = {
    Height = ScrH( ),
    Width  = ScrW( )
}

Coffee.Gamemode = engine.ActiveGamemode( )

Coffee.Config = { }

-- =============================================================================
-- Setup utility functions.
-- =============================================================================

function Coffee:Print( isError, Text, ... )
    local Prefix = isError and '[ ERROR ]' or '[ COFFEE ]'
    local Color  = isError and self.Colors[ 'Red' ] or self.Colors[ 'Main' ]

    MsgC( Color, Prefix, ' ', self.Colors[ 'White' ], string.format( Text, ... ), '\n' )
end

-- =============================================================================
-- Setup environment.
-- =============================================================================

Coffee:Print( false, 'Setting up environment...' )

Coffee._G = table.Copy( _G )

Coffee.Environment = setmetatable( {
    _G  = Coffee._G,
    __G = _G,

    Coffee = Coffee
}, {
    __index = Coffee._G
} )

function Coffee:Load( Code, Environment, ... )
    local Function = CompileString( Code, 'Coffee' )   

    if ( not Function ) then 
        return self:Print( true, 'Failed to compile code! (%s, %s)', string.NiceSize( #Code ), util.CRC( Code ) )
    end

    if ( Environment ) then 
        Function = setfenv( Function, Environment )
    end

    return true, Function( ... )
end

function Coffee:LoadFile( Directory, Insecure )
    local Handle = file.Open( Directory, 'rb', 'GAME' )

    if ( not Handle ) then 
        return self:Print( true, 'Failed to open handle to file %s!', string.GetFileFromFilename( Directory ) )
    end

    local Valid, Data = self:Load( Handle:Read( Handle:Size( ) ), not Insecure and self.Environment or nil )

    if ( Valid ) then 
        Coffee:Print( false, 'Successfully loaded file %s!', Directory )
    else 
        Coffee:Print( false, 'Failed loaded file %s!', Directory )
    end

    Handle:Close( )

    return Data
end

function Coffee:LoadDirectory( Directory, Insecure )
    local Files = file.Find( Directory .. '*.lua', 'GAME' )

    for i = 1, #Files do
        self:LoadFile( Directory .. Files[ i ], Insecure )
    end
end

-- =============================================================================
-- Load libraries.
-- =============================================================================

Coffee:Print( false, 'Loading libraries...' )

if ( not Coffee:LoadFile( 'lua/coffee/libraries/cpp/modmgr.lua' ) ) then 
    return 
end

Coffee:LoadFile( 'lua/coffee/libraries/external/random.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/render/materials.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/render/beams.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/sdk/engine.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/hitboxes.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/enum.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/hookmgr.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/items.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/render/overlay.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/render/hitmarker.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/sdk/fullupdate.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/optimizations.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/client.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/records.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/notify.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/shots.lua' )
Coffee:LoadFile( 'lua/coffee/libraries/sdk/createmove.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/render/csent.lua' )

Coffee:LoadFile( 'lua/coffee/libraries/gamemodes/handler.lua' )

-- =============================================================================
-- Load modules.
-- =============================================================================

Coffee:Print( false, 'Loading modules...' )

Coffee:LoadFile( 'lua/coffee/modules/menu/menu.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/form.lua' )

Coffee:LoadFile( 'lua/coffee/modules/ragebot/main.lua' )

Coffee:LoadFile( 'lua/coffee/modules/visuals/main.lua' )

Coffee:LoadFile( 'lua/coffee/modules/miscellaneous/main.lua' )

-- =============================================================================
-- Gather dynamic files.
-- =============================================================================

Coffee:Print( false, 'Gathering dynamic files...' )

Coffee:LoadDirectory( 'coffee/safe/', false )
Coffee:LoadDirectory( 'coffee/unsafe/', true )