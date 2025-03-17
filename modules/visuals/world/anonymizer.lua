Coffee.Anonymizer = {    
    Config = Coffee.Config,

    Symbols = {
        '!',
        '#',
        '?',
        '/',
        '$',
        '%',
        '^',
        '&',
        '*'
    }
}

function Coffee.Anonymizer:GenerateName( Length )
    local Name = ''

    for i = 1, Length do 
        Name = Name .. self.Symbols[ math.random( #self.Symbols ) ]
    end

    return Name
end

function Coffee.Anonymizer:Update( )
    if ( not self.Config[ 'world_anonymizer' ] ) then 
        return 
    end

    local List = vgui.GetAll( )

    for i = 1, #List do 
        local Panel = List[ i ]

        if ( not Panel or not Panel:IsValid( ) ) then 
            continue
        end

        Panel:SetPlayer( NULL ) 
    end
end

local Meta = FindMetaTable( 'Player' )
local Copy = table.Copy( Meta )

-- As said in the taunt bypass section of the anti-aim, this will need to be streamlined via a true
-- detour and security library.
Meta.Name = function( self )
    if ( Coffee.Anonymizer.Config[ 'world_anonymizer' ] ) then 
        return Coffee.Anonymizer:GenerateName( Coffee.Anonymizer.Config[ 'world_anonymizer_length' ] )
    end

    return Copy.Name( self )
end

Meta.Nick = function( self )
    if ( Coffee.Anonymizer.Config[ 'world_anonymizer' ] ) then 
        return Coffee.Anonymizer:GenerateName( Coffee.Anonymizer.Config[ 'world_anonymizer_length' ] )
    end

    return Copy.Nick( self )
end

Meta.GetName = function( self )
    if ( Coffee.Anonymizer.Config[ 'world_anonymizer' ] ) then 
        return Coffee.Anonymizer:GenerateName( Coffee.Anonymizer.Config[ 'world_anonymizer_length' ] )
    end

    return Copy.Name( self )
end