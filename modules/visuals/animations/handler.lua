function Coffee.Visuals:UpdateAnimations( ENT, Velocity )
    if ( ENT != self.Client.Local ) then 
        return
    end

    -- Get our angle.
    local Angle = self.Config[ 'hvh_enabled' ] and self.Ragebot.Fake or ENT:GetRenderAngles( )

    -- Set our data.
    ENT:SetPoseParameter( 'aim_pitch', Angle.x )

    ENT:SetRenderAngles( Angle )

    -- Check if we need to adjust angles further than normal.
    if ( self.Config[ 'hvh_animations' ] ) then 
        if ( self.Config[ 'hvh_animations_force_slide' ] ) then 
            self.Client.Local:SetCycle( 0 )
        end
    end

    -- Invalidate bone cache and setup bones.
    ENT:InvalidateBoneCache( )
end

Coffee.Hooks:New( 'UpdateAnimation', Coffee.Visuals.UpdateAnimations, Coffee.Visuals )