-- =============================================================================
-- Setup constants.
-- =============================================================================

local Coffee = { }

Coffee.Colors = { 
    [ 'Main' ]       = Color( 133, 99, 88 ), 
    [ 'Main Light' ] = Color( 179, 156, 149 ),

    [ 'White' ] = Color( 255, 255, 255 ),
    [ 'Black' ] = Color( 0, 0, 0 ),
    [ 'Gray' ]  = Color( 30, 30, 30 ),
    
    [ 'Dark Gray' ] = Color( 18, 18, 18 ),

    [ 'Red' ]   = Color( 255, 0, 0 ),
    [ 'Green' ] = Color( 0, 255, 0 ),
    [ 'Blue' ]  = Color( 0, 0, 255 ),
}

Coffee.Localplayer = LocalPlayer( )

Coffee.Resolution = {
    Height = ScrH( ),
    Width  = ScrW( )
}

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
    local Function = CompileString( Code )   

    if ( not Function ) then 
        return self:Print( true, 'Failed to compile code! (%s, %s)', string.NiceSize( #Code ), util.CRC( Code ) )
    end

    if ( Environment ) then 
        Function = setfenv( Function, Environment )
    end

    Function( ... )

    return true
end

function Coffee:LoadFile( Directory )
    local Handle = file.Open( Directory, 'rb', 'GAME' )

    if ( not Handle ) then 
        return self:Print( true, 'Failed to open handle to file %s!', string.GetFileFromFilename( Directory ) )
    end

    if ( self:Load( Handle:Read( Handle:Size( ) ), self.Environment ) ) then 
        Coffee:Print( false, 'Successfully loaded file %s!', Directory )
    else 
        Coffee:Print( false, 'Failed loaded file %s!', Directory )
    end

    Handle:Close( )
end

-- =============================================================================
-- Load libraries.
-- =============================================================================

Coffee:Print( false, 'Loading libraries...' )

Coffee:LoadFile( 'lua/coffee/libraries/sdk/hookmgr.lua' )

-- =============================================================================
-- Load modules.
-- =============================================================================

Coffee:Print( false, 'Loading modules...' )

Coffee:LoadFile( 'lua/coffee/modules/menu/menu.lua' )
Coffee:LoadFile( 'lua/coffee/modules/menu/form.lua' )

-- =============================================================================
-- Gather dynamic files.
-- =============================================================================

Coffee:Print( false, 'Gathering dynamic files...' )
