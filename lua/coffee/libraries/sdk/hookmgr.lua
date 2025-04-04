Coffee.Hooks = { 
    Cache = { }
}

function Coffee.Hooks:Call( Event, ... )
    local Cache = self.Cache

    if ( not Cache[ Event ] ) then 
        return
    end

    for i = 1, #Cache[ Event ] do 
        local Index = Cache[ Event ][ i ]

        if ( Index.Meta ) then 
            Index.Callback( Index.Meta, ... )
        else
            Index.Callback( ... )
        end
    end
end

function Coffee.Hooks:New( Event, Callback, Meta )
    if ( not self.Cache[ Event ] ) then 
        Coffee:Print( false, 'Hooking event "%s"...', Event )

        local Cache = self.Cache

        Cache[ Event ] = { }

        hook.Add( Event, 'Coffee', function( ... )
            for i = 1, #Cache[ Event ] do 
                local Index, Value = Cache[ Event ][ i ], nil

                if ( Index.Meta ) then 
                    Value = { Index.Callback( Index.Meta, ... ) }
                else
                    Value = { Index.Callback( ... ) }
                end

                if ( Value and #Value != 0 ) then 
                    return unpack( Value )
                end
            end
        end )
    end

    table.insert( self.Cache[ Event ], {
        Meta     = Meta,
        Callback = Callback
    } )
end