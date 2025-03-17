Coffee.Ragebot.HL2 = { 
    UniformRandomStream = UniformRandomStream( ),

    ai_shot_bias     = GetConVar( 'ai_shot_bias' ),
    ai_shot_bias_min = GetConVar( 'ai_shot_bias_min' ),
    ai_shot_bias_max = GetConVar( 'ai_shot_bias_max' )
}

function Coffee.Ragebot.HL2:RunTrace( Record, Matrix, Autowall, Minimum )
    local Trace = util.TraceLine( { start = self.Client.EyePos, endpos = Matrix, filter = { self.Client.Local, Record.Target }, mask = MASK_SHOT } )

    return Trace.Fraction == 1
end

function Coffee.Ragebot.HL2:CalculateSpread( Spot, Cone, Seed )
    -- https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/shared/shot_manipulator.h#L59

    self.UniformRandomStream:SetSeed( Seed )

    local X, Y, Z = 0, 0, 0
    local Bias = self.ai_shot_bias:GetFloat( )

    local shotBiasMin = self.ai_shot_bias_min:GetFloat( )
    local shotBiasMax = self.ai_shot_bias_max:GetFloat( )

    local shotBias = ( ( shotBiasMax - shotBiasMin ) * Bias ) + shotBiasMin
    local Flatness = math.abs( shotBias ) * 0.5

    repeat
        X = self.UniformRandomStream:RandomFloat( -1, 1 ) * Flatness + self.UniformRandomStream:RandomFloat( -1, 1 ) * ( 1 - Flatness )
        Y = self.UniformRandomStream:RandomFloat( -1, 1 ) * Flatness + self.UniformRandomStream:RandomFloat( -1, 1 ) * ( 1 - Flatness )

        if ( shotBias < 0 ) then
            X = ( X >= 0 ) and 1.0 - X or -1.0 - X
            Y = ( Y >= 0 ) and 1.0 - Y or -1.0 - X
        end

        Z = ( X * X ) + ( Y * Y )
    until Z <= 1
    
    return ( Spot:Forward( ) + ( X * Cone[ 1 ] * Spot:Right( ) * -1 ) + ( Y * Cone[ 2 ] * Spot:Up( ) * -1 ) ):Angle( )
end

function Coffee.Ragebot.HL2:CalculateRecoil( CUserCMD, Spot, SWEP )
    return self.Client.Local:GetViewPunchAngles( )
end

function Coffee.Ragebot.HL2:CalculateCompensation( CUserCMD, Spot, Recoil, Spread )
    if ( isvector( Spot ) ) then 
        Spot = Spot:Angle( )
    end
    
    -- Get current weapon cone.
    local SWEP = self.Client.Local:GetActiveWeapon( )

    if ( not SWEP or not SWEP:IsValid( ) ) then 
        return Spot
    end

    if ( Recoil ) then
        if ( not SWEP:IsScripted( ) ) then 
            Spot = Spot - self:CalculateRecoil( )
        end
    elseif ( SWEP:IsScripted( ) ) then 
        Spot = Spot + self:CalculateRecoil( )
    end

    if ( not Spread ) then 
        return Spot
    end

    local Cone = self.Cones[ SWEP:GetPrintName( ) ]

    if ( not Cone ) then 
        return Spot
    end

    -- Get our spread calculation.
    Spot = self:CalculateSpread( Spot, Cone, self.Require:GetRandomSeed( CUserCMD ) )

    Spot:Normalize( )

    return Spot
end