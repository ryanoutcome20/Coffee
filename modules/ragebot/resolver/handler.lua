function Coffee.Ragebot:OnMissedShot( wasResolver, Record )
    if ( not wasResolver ) then 
        return
    end

    if ( not self.Config[ 'aimbot_resolver' ] ) then 
        return
    end

    local Index = self.Indexes[ Record.Target:EntIndex( ) ] or 0

    Index = Index + 1

    self.Indexes[ Record.Target:EntIndex( ) ] = Index
end

function Coffee.Ragebot:Resolve( Record )
    -- Check if they're using a fake.
    if ( not Record.Fake and self.Config[ 'aimbot_resolver_only_detect' ] ) then 
        return
    end

    local Angles = angle_zero

    -- Get our misses.
    local Misses = self.Indexes[ Record.Target:EntIndex( ) ] or 0

    -- Check if we'll be using an extended mode.
    local Extended = self.Config[ 'aimbot_resolver_mode' ] == 'Extended'

    -- Adjust the yaw portion of the angles.
    Angles.y = math.NormalizeAngle( Record.Angles.y )

    if ( not Extended ) then  
        local Amount = Misses % 3

        if ( Amount == 0 ) then 
            Angles.y = Angles.y
        elseif ( Amount == 1 ) then
            Angles.y = Angles.y - 35
        else 
            Angles.y = Angles.y + 35
        end
    else
        Angles.y = math.NormalizeAngle( ( 45 * Misses ) % 360 )
    end

    -- If we are using a fake pitch then we need to flip they're view angles.
    Angles.x = Record.Angles.x

    if ( Record.Fake ) then 
        local Amount = Extended and Misses % 18 or Misses % 7

        if ( Amount == 0 ) then 
            Angles.x = 0
        elseif ( Extended and Amount > 8 ) then 
            Angles.x = 89
        elseif ( not Extended and Amount > 3 ) then
            Angles.x = 89 
        else
            Angles.x = -89
        end
    end

    return angle_zero
end

function Coffee.Ragebot:UpdateResolver( ENT, Record )
    if ( ENT == self.Client.Local ) then 
        return
    end

    if ( not self.Config[ 'aimbot_resolver' ] ) then 
        return
    end

    -- Check if we're getting called by the hook.
    if ( isvector( Record ) ) then 
        Record = nil
    end

    -- Get front record.
    local Front = Record or self.Records:GetFront( ENT )

    if ( not Front ) then 
        return 
    end

    -- Get our angle.
    local Angle = self:Resolve( Front ) or Front.Angles

    if ( self.Config[ 'aimbot_resolver_serverside' ] ) then 
        Angle = ENT:GetNW2Angle( 'SVR' ) or Angle
    end

    -- Set our data.
    ENT:SetPoseParameter( 'aim_pitch', Angle.x )
    ENT:SetPoseParameter( 'head_pitch', Angle.x )
    ENT:SetPoseParameter( 'move_x', Angle.x )

    ENT:SetPoseParameter( 'aim_yaw', Angle.y )
    ENT:SetPoseParameter( 'head_yaw', Angle.y )
    ENT:SetPoseParameter( 'move_y', Angle.y )

    ENT:SetRenderAngles( Angle )

    -- Invalidate bone cache and setup bones.
    ENT:InvalidateBoneCache( )
end

Coffee.Hooks:New( 'UpdateAnimation', Coffee.Ragebot.UpdateResolver, Coffee.Ragebot )
Coffee.Hooks:New( 'Missed', Coffee.Ragebot.OnMissedShot, Coffee.Ragebot )