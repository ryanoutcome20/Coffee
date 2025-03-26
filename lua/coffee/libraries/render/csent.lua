Coffee.CSEntity = { 
    Records = Coffee.Records,

    Cache = { }
}

function Coffee.CSEntity:New( Identifier, Parent )
    if ( self.Cache[ Identifier ] ) then 
        return self.Cache[ Identifier ]
    end

    local ENT = ClientsideModel( 'models/error.mdl' )

    if ( Parent ) then 
        self:SetModel( ENT, Parent:GetModel( ) )
        self:SetPosition( ENT, Parent:GetPos( ) )
        self:SetAngles( ENT, Parent:EyeAngles( ) )
        
        -- Don't assign animations in here, let the user do it manually.
    end

    self.Cache[ Identifier ] = ENT

    return ENT
end

function Coffee.CSEntity:Get( Identifier )
    local Index = self.Cache[ Identifier ]

    if ( not Index ) then 
        Index = self:New( Identifier )
    end

    return Index
end

function Coffee.CSEntity:Remove( Identifier, ENT )
    if ( not ENT ) then 
        ENT = self.Cache[ Identifier ]

        if ( not ENT ) then 
            return
        end
    end

    ENT:Remove( )

    self.Cache[ Identifier ] = nil
end

function Coffee.CSEntity:SetModel( ENT, Model )
    ENT:SetModel( Model )
end

function Coffee.CSEntity:SetPosition( ENT, Origin )
    ENT:SetPos( Origin )
end

function Coffee.CSEntity:SetAngles( ENT, Angles )
    ENT:SetAngles( Angle( 0, Angles.y, 0 ) )
end

function Coffee.CSEntity:AssignAnimations( ENT, Animations )
    ENT:SetSequence( Animations.Sequence )
    ENT:SetCycle( Animations.Cycle )
    ENT:SetColor( Color( Animations.Color.r, Animations.Color.g, Animations.Color.b, 0 ) )

    for k,v in pairs( Animations.Layers ) do 
        ENT:SetLayerWeight( k, v.Weight )
        ENT:SetLayerCycle( k, v.Cycle )
        ENT:SetLayerDuration( k, v.Duration )
        ENT:SetLayerPlaybackRate( k, v.Playback )
    end

    for k,v in pairs( Animations.Poses ) do 
        ENT:SetPoseParameter( k, v )
    end

    ENT:SetPoseParameter( 'aim_pitch', Animations.Angles.x )
    ENT:SetPoseParameter( 'body_yaw', Animations.Angles.y )

    ENT:InvalidateBoneCache( )
    ENT:SetupBones( )
end