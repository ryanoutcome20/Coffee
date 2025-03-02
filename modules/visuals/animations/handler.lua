function Coffee.Visuals:UpdateAnimations( ENT, Velocity )
    if ( ENT != self.Client.Local ) then 
        return
    end

    -- Get our angle.
    local Angle = self.Config[ 'hvh_enabled' ] and self.Ragebot.Fake or ENT:GetRenderAngles( )

    -- Set our data.
    ENT:SetPoseParameter( 'aim_pitch', Angle.x )

    ENT:SetRenderAngles( Angle )

    -- Fix bone jiggle adjustment.
    local Origin = Vector( 1, 1, 1 )

    for i = 0, self.Client.Local:GetBoneCount( ) do 
        self.Client.Local:ManipulateBoneJiggle( i, 0 )
        self.Client.Local:ManipulateBoneScale( i, Origin )
    end

    -- Check if we need to adjust angles further than normal.
    if ( self.Config[ 'hvh_animations' ] ) then 
        if ( self.Config[ 'hvh_animations_force_slide' ] ) then 
            self.Client.Local:SetCycle( 0 )
        end

        if ( self.Config[ 'hvh_animations_jelly' ] ) then 
            for i = 0, self.Client.Local:GetBoneCount( ) do 
                self.Client.Local:ManipulateBoneJiggle( i, 1 )
            end
        end

        if ( self.Config[ 'hvh_animations_scale' ] ) then 
            local Scale = self.Config[ 'hvh_animations_scale_amount' ] / 100

            Scale = Vector( Scale, Scale, Scale )

            for i = 0, self.Client.Local:GetBoneCount( ) do 
                self.Client.Local:ManipulateBoneScale( i, Scale )
            end
        end
    end

    -- Invalidate bone cache and setup bones.
    ENT:InvalidateBoneCache( )
end

Coffee.Hooks:New( 'UpdateAnimation', Coffee.Visuals.UpdateAnimations, Coffee.Visuals )