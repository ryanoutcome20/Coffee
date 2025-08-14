function Coffee.Visuals:UpdateAnimations( ENT, Velocity )
    if ( ENT != self.Client.Local ) then 
        return
    end

    -- Get our angle.
    local Angle = Coffee.Config[ 'hvh_enabled' ] and self.Ragebot.Real or ENT:EyeAngles( )

    -- Set our data.
    ENT:SetPoseParameter( 'aim_pitch', Angle.x )
    ENT:SetPoseParameter( 'body_yaw', Angle.y )

    ENT:SetRenderAngles( Angle )

    -- Fix bone jiggle adjustment.
    local Origin = Vector( 1, 1, 1 )
    local Jiggle = false

    -- Check if we need to adjust angles further than normal.
    if ( Coffee.Config[ 'hvh_animations' ] ) then 
        if ( Coffee.Config[ 'hvh_animations_force_slide' ] ) then 
            self.Client.Local:SetCycle( 0 )
        end

        Jiggle = Coffee.Config[ 'hvh_animations_jelly' ]

        if ( Coffee.Config[ 'hvh_animations_scale' ] ) then 
            local Scale = Coffee.Config[ 'hvh_animations_scale_amount' ] / 100

            Origin = Vector( Scale, Scale, Scale )
        end
    end

    -- Update bone animations.
    Jiggle = Jiggle and 1 or 0

    for i = 0, self.Client.Local:GetBoneCount( ) do 
        self.Client.Local:ManipulateBoneJiggle( i, Jiggle )
        self.Client.Local:ManipulateBoneScale( i, Origin )
    end

    -- Invalidate bone cache and setup bones.
    ENT:InvalidateBoneCache( )
end

Coffee.Hooks:New( 'UpdateAnimation', Coffee.Visuals.UpdateAnimations, Coffee.Visuals )

-- We'll keep this here for now until we have a detour module or security script for Coffee.
FindMetaTable( 'Player' ).IsPlayingTaunt = function( ... )
    return false
end