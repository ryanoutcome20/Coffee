Coffee.Hitboxes = { 
    Cache = { }
}

function Coffee.Hitboxes:ParseInformation( ENT )
    -- Get our model and start our cache.
    local Model = ENT:GetModel( )

    self.Cache[ Model ] = { }

    -- Get our sets.
    local Temp, Sets = { }, ENT:GetHitboxSetCount( )

    if Sets == 0 then return Temp end 
    
    -- Loop through sets and count to get bone information.
    for i = 0, Sets - 1 do
        local Count = ENT:GetHitBoxCount( i )

        for c = 0, Count do 
            local Group, Bone = ENT:GetHitBoxHitGroup( c, i ), ENT:GetHitBoxBone( c, i )

            if not Group or not Bone then continue end 

            local Name = ENT:GetBoneName( Bone )

            if not Name then continue end 

            if Name == '__INVALIDBONE__' then
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

    if Data == '__INVALIDBONE__' then 
        self:ParseInformation( ENT )
        return
    elseif not Data then 
        Data = self:ParseInformation( ENT )
    end

    for k,v in pairs( Data ) do 
        local Internal = { }

        for i = 1, #v do 
            local Info = v[ i ]

            local Bone = ENT:LookupBone( Info.Name )

            if not Bone then 
                return self:ParseInformation( ENT )
            end

            local Matrix, Ang = ENT:GetBonePosition( Bone )

            if not Matrix or not Ang then 
                continue
            end 
            
            table.insert( Internal, Matrix )
        end

        Temp[ k ] = Internal
    end

    return Temp
end

concommand.Add( 'test_hit', function( )
    PrintTable( Coffee.Hitboxes )
end )