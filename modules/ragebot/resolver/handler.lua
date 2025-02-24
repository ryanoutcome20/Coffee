function Coffee.Ragebot:Resolve( Record )
    return angle_zero
end

function Coffee.Ragebot:UpdateResolver( ENT, Velocity )
    if ( not self.Config[ 'aimbot_resolver' ] ) then 
        return
    end

    -- Get front record.
    local Front = self.Records:GetFront( ENT )

    if ( not Front ) then 
        return 
    end

    -- Check if they're using a fake.
    if ( not Front.Fake and self.Config[ 'aimbot_resolver_only_detect' ] ) then 
        return
    end

    -- Get our angle.
    local Angle = self:Resolve( Front )

    if ( self.Config[ 'aimbot_resolver_serverside' ] ) then 
        Angle = ENT:GetNW2Angle( 'SVR' ) or Angle
    end

    -- Set our data.
    ENT:SetPoseParameter( 'aim_pitch', Angle.x )

    ENT:SetRenderAngles( Angle )

    -- Invalidate bone cache and setup bones.
    ENT:InvalidateBoneCache( )
end

Coffee.Hooks:New( 'UpdateAnimation', Coffee.Ragebot.UpdateResolver, Coffee.Ragebot )