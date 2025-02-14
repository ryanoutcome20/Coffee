Coffee.Hooks = { 
    Cache = { }
}

function Coffee.Hooks:New( Event, Callback, Meta )
    if not self.Cache[ Event ] then 
        Coffee:Print( false, 'Hooking event "%s"...', Event )

        local Cache = self.Cache

        Cache[ Event ] = { }
    
        hook.Add( Event, 'Coffee', function( ... )
            for i = 1, #Cache[ Event ] do 
                local Index = Cache[ Event ][ i ]

                if ( Index.Meta ) then 
                    return Index.Callback( Index.Meta, ... )
                end

                Index.Callback( ... )
            end
        end )
    end

    table.insert( self.Cache[ Event ], {
        Meta     = Meta,
        Callback = Callback
    } )
end