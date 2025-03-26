Coffee.Enum = { }

function Coffee.Enum:Launch( Name )
    local Data = Coffee:LoadFile( 'lua/coffee/libraries/enums/' .. Name .. '.lua' )

    if ( not Data ) then 
        return 
    end

    Coffee:Print( false, 'Enumeration loaded "%s"...', Name )

    -- This is actually the custom environment.
    table.Merge( _G, Data )
end

Coffee.Enum:Launch( 'framestage' )
Coffee.Enum:Launch( 'ttt' )
Coffee.Enum:Launch( 'createstage' )