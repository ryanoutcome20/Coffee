Coffee.Hitboxes = { 
    Config = Coffee.Config,

    Cache = { }
}

function Coffee.Hitboxes:HandleMultipoint( ENT, Matrix, Offset, Info )
    if ( not self.Config[ 'aimbot_multipoint' ] ) then 
        return
    end

    local Final = { }

    -- Get the scale.
    local Scale = Info.Group == HITGROUP_HEAD and self.Config[ 'aimbot_multipoint_head_scale' ] or self.Config[ 'aimbot_multipoint_other_scale' ]

    Scale = Scale / 200

    -- Calculate Mins/Maxs.
    local Mins, Maxs = ENT:GetHitBoxBounds( Info.Hitbox, Info.Set )

    -- Calculate points.
    local Points = {
        ( ( Mins + Maxs ) * 0.5 ),
        Vector( Mins.x, Mins.y, Mins.z ),
        Vector( Mins.x, Maxs.y, Mins.z ),
        Vector( Maxs.x, Maxs.y, Mins.z ),
        Vector( Maxs.x, Mins.y, Mins.z )
    }

    -- Rotate points.
    -- https://developer.valvesoftware.com/wiki/Rotation_Tutorial
    for i = 1, #Points do
        Points[ i ]:Rotate( Offset )
        Points[ i ] = Points[ i ] + Matrix
        
        if ( i == 1 ) then 
            table.insert( Final, Points[ i ] )
            continue
        end

        Points[ i ] = ( ( Points[ i ] - Points[ 1 ] ) * Scale ) + Points[ 1 ]
        
        table.insert( Final, Points[ i ] )
    end

    return Final
end

function Coffee.Hitboxes:ParseInformation( ENT )
    -- Get our model and start our cache.
    local Model = ENT:GetModel( )

    self.Cache[ Model ] = { }

    -- Get our sets.
    local Temp, Sets = { }, ENT:GetHitboxSetCount( )

    if ( Sets == 0 ) then 
        return Temp 
    end 
    
    -- Loop through sets and count to get bone information.
    for i = 0, Sets - 1 do
        local Count = ENT:GetHitBoxCount( i )

        for c = 0, Count do 
            local Group, Bone = ENT:GetHitBoxHitGroup( c, i ), ENT:GetHitBoxBone( c, i )

            if ( not Group or not Bone ) then 
                continue 
            end 

            local Name = ENT:GetBoneName( Bone )

            if ( not Name ) then 
                continue 
            end 

            if ( Name == '__INVALIDBONE__' ) then
                self.Cache[ Model ] = '__INVALIDBONE__'
                return { }
            end 

            Temp[ Group ] = Temp[ Group ] or { }

            table.insert( Temp[ Group ],  { Name = Name, Hitbox = c, Set = i, Group = Group } )
        end
    end

    self.Cache[ Model ] = Temp
    
    return Temp
end

function Coffee.Hitboxes:GetMatrixInformation( ENT )
    local Temp, Data = { }, self.Cache[ ENT:GetModel( ) ]

    if ( Data == '__INVALIDBONE__' ) then 
        self:ParseInformation( ENT )
        return
    elseif ( not Data ) then 
        Data = self:ParseInformation( ENT )
    end

    for k,v in pairs( Data ) do 
        local Internal = { }

        for i = 1, #v do 
            local Info = v[ i ]

            local Bone = ENT:LookupBone( Info.Name )

            if ( not Bone ) then 
                return self:ParseInformation( ENT )
            end

            local Matrix, Offset = ENT:GetBonePosition( Bone )

            if ( not Matrix or not Offset ) then 
                continue
            end 
            
            table.insert( Internal, Matrix )
        
            local Points = self:HandleMultipoint( ENT, Matrix, Offset, Info )

            if ( Points ) then 
                table.Add( Internal, Points )
            end
            
            if ( Info.Group == HITGROUP_HEAD ) then 
                Internal = table.Reverse( Internal )
            end
        end

        Temp[ k ] = Internal
    end

    return Temp
end