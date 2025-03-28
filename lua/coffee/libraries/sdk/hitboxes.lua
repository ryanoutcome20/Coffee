Coffee.Hitboxes = { 
    Config = Coffee.Config,

    Cache = { }
}

function Coffee.Hitboxes:GetSimpleBones( ENT, Target )
    local Sets = ENT:GetHitboxSetCount( )
    local Bones = { }

    if ( not Sets ) then 
        return Bones 
    end

    for Set = 0, Sets - 1 do
        local Hitboxes = ENT:GetHitBoxCount( Set )
    
        if ( not Hitboxes ) then 
            continue
        end

        for Hitbox = 0, Hitboxes - 1 do
            if ( Target ) then 
                local Group = ENT:GetHitBoxHitGroup( Hitbox, Set )
                
                if ( not Group or Group != Target ) then 
                    continue
                end
            end

            local Bone = ENT:GetHitBoxBone( Hitbox, Set )

            if ( not Bone ) then 
                continue
            end
            
            local Origin, Angles = ENT:GetBonePosition( Bone )

            if ( not Origin or not Angles ) then 
                continue
            end
            
            local Mins, Maxs = ENT:GetHitBoxBounds( Hitbox, Set )
            
            if ( not Mins or not Maxs ) then 
                continue
            end

            table.insert( Bones, {
                Mins   = Mins,
                Maxs   = Maxs,
                Origin = Origin,
                Angles = Angles
            } )
        end
    end

    return Bones
end

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

function Coffee.Hitboxes:AddCenter( ENT, Internal )
    Internal[ HITGROUP_STOMACH ] = Internal[ HITGROUP_STOMACH ] or { }

    table.insert( 
        Internal[ HITGROUP_STOMACH ], 
        ENT:LocalToWorld( ENT:OBBCenter( ) ) 
    )

    return Internal
end

function Coffee.Hitboxes:ParseInformation( ENT )
    -- Get our model and start our cache.
    local Model = ENT:GetModel( )

    self.Cache[ Model ] = { }

    -- Get our sets.
    local Temp, Sets = { }, ENT:GetHitboxSetCount( )

    if ( not Sets or Sets == 0 ) then 
        return Temp 
    end 
    
    -- Loop through sets and count to get bone information.
    for Set = 0, Sets - 1 do
        local Count = ENT:GetHitBoxCount( Set )

        for Hitbox = 0, Count do 
            local Group, Bone = ENT:GetHitBoxHitGroup( Hitbox, Set ), ENT:GetHitBoxBone( Hitbox, Set )

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

            table.insert( Temp[ Group ], { 
                Name   = Name, 
                Hitbox = Hitbox, 
                Set    = Set, 
                Group  = Group 
            } )
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

    -- I'm going to guess and say that the aiming at vector_origin when
    -- the player spawns is because they are actually at the vector_origin
    -- when the player spawns. If your laggy enough you can even see they're weapon
    -- at vector_origin.

    local Origin = ENT:GetPos( )

    for k,v in pairs( Data ) do 
        local Internal = { }

        for i = 1, #v do 
            local Info = v[ i ]

            local Bone = ENT:LookupBone( Info.Name )

            if ( not Bone ) then 
                return self:ParseInformation( ENT )
            end

            local Matrix = ENT:GetBoneMatrix( Bone )

            if ( not Matrix or Matrix:IsZero( ) ) then 
                continue
            end

            local Position, Offset = Matrix:GetTranslation( ), Matrix:GetAngles( )

            if ( not Position or not Offset ) then 
                continue
            end 

            if ( Position == vector_origin or Position == Origin ) then 
                continue
            end
            
            table.insert( Internal, Position )
        
            local Points = self:HandleMultipoint( ENT, Position, Offset, Info )

            if ( Points ) then 
                table.Add( Internal, Points )
            end
            
            if ( Info.Group == HITGROUP_HEAD ) then 
                Internal = table.Reverse( Internal )
            end
        end

        Temp[ k ] = Internal
    end

    return self:AddCenter( ENT, Temp )
end