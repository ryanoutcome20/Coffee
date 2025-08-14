Coffee.Ragebot.M9K = {
    UniformRandomStream = UniformRandomStream( ),

    ai_shot_bias     = GetConVar( 'ai_shot_bias' ),
    ai_shot_bias_min = GetConVar( 'ai_shot_bias_min' ),
    ai_shot_bias_max = GetConVar( 'ai_shot_bias_max' ),

    M9KDamageMultiplier = GetConVar( 'M9KDamageMultiplier' ),

    Scale = {
        [ 'SniperPenetratedRound' ] = 20,
        [ 'pistol' ]                = 9,
        [ '357' ]                   = 12,
        [ 'smg1' ]                  = 14,
        [ 'ar2' ]                   = 16,
        [ 'buckshot' ]              = 5,
        [ 'slam' ]                  = 5,
        [ 'AirboatGun' ]            = 17,
    },

    extraMaterials = {
        [ MAT_GLASS ]      = true,
        [ MAT_PLASTIC ]    = true,
        [ MAT_WOOD ]       = true,
        [ MAT_FLESH ]      = true,
        [ MAT_ALIENFLESH ] = true
    }
}

function Coffee.Ragebot.M9K:RunTrace( Record, Matrix, Autowall, Minimum )
    local Trace = util.TraceLine( { 
        start = self.Client.EyePos, 
        endpos = Matrix, 
        filter = { self.Client.Local, Record.Target }, 
        mask = MASK_SHOT 
    } )

    if ( Trace.Fraction == 1 ) then 
        return true
    end

    if ( not Autowall ) then 
        if ( Coffee.Config[ 'aimbot_engine_entity' ] and self:PenetrateEntities( Trace, Record )  ) then
            return true
        end

        return false
    end

    -- Get the weapons ammo type.
    local Ammo   = self.Client.Weapon.Primary.Ammo

    -- Cannot begin penetration on these ammo types.
    if ( Ammo == 'pistol' or Ammo == 'buckshot' or Ammo == 'slam' ) then 
        return false
    end

    -- Adjust scales.
    local Scale = self.Scale[ Ammo ] or 14

    -- Get direction.
    local Direction = Trace.Normal * Scale
	   
    if ( self.extraMaterials[ Trace.MatType ] ) then
        Direction = Trace.Normal * ( Scale * 2 )
    end

    -- Run trace. It will start where the last one ended plus the direction, we are
    -- trying to see if this bullet will go through (distance wise) the thickness of
    -- whatever it is penetrating.
    local Penetration = util.TraceLine( { 
        start = Trace.HitPos + Direction, 
        endpos = Trace.HitPos + Trace.Normal * 4096, 
        filter = { self.Client.Local }, 
        mask = MASK_SHOT 
    } )

    if ( Penetration.StartSolid or Penetration.Fraction >= 1.0 ) then 
        return false
    end

    if ( not Penetration.Entity or Penetration.Entity != Record.Target ) then 
        return false
    end

    -- Check minimum damage.
    local Damage = 0.5

    if ( Ammo == 'SniperPenetratedRound' ) then
        Damage = 1
    elseif( Trace.MatType == MAT_CONCRETE or Trace.MatType == MAT_METAL ) then
        Damage = 0.3
    elseif ( Trace.MatType == MAT_WOOD or Trace.MatType == MAT_PLASTIC or Trace.MatType == MAT_GLASS ) then
        Damage = 0.8
    elseif ( Trace.MatType == MAT_FLESH or Trace.MatType == MAT_ALIENFLESH ) then
        Damage = 0.9
    end

    return self.Client.Weapon.Primary.Damage * Damage > Minimum
end

function Coffee.Ragebot.M9K:Damage( Record, Group )
    local Damage, ID = self:GetWeaponDamage( self.Client.Weapon, Group )

    Damage = self:GetWeaponDamageScale( Damage, ID, Group )

    if ( Coffee.Config[ 'aimbot_minimum_damage_damage' ] <= Damage ) then 
        return true
    end
end

function Coffee.Ragebot.M9K:CalculateSpread( CUserCMD, Spot, Cone, Seed )
    -- https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/shared/shot_manipulator.h#L59

    if ( Coffee.Config[ 'aimbot_nospread_engine' ] ) then 
        return Spot + ded.PredictSpread( CUserCMD, Spot, Cone ):Angle( )
    end

    if ( Coffee.Config[ 'aimbot_nospread_offset' ] ) then 
        Seed = Seed + Coffee.Config[ 'aimbot_nospread_offset_seed' ]
    end

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

function Coffee.Ragebot.M9K:CalculateRecoil( CUserCMD, Spot, SWEP )
    return self.Client.Local:GetViewPunchAngles( )
end

function Coffee.Ragebot.M9K:CalculateCompensation( CUserCMD, Spot, Recoil, Spread )
    if ( isvector( Spot ) ) then 
        Spot = Spot:Angle( )
    end
    
    -- Get current weapon cone.
    local SWEP = self.Client.Local:GetActiveWeapon( )

    if ( not SWEP or not SWEP:IsValid( ) ) then 
        return Spot
    end

    if ( not Recoil ) then
        Spot = Spot - self:CalculateRecoil( )
    end

    if ( not Spread ) then 
        return Spot
    end

    local Cone = self.Cones[ SWEP:GetPrintName( ) ]

    if ( not Cone ) then 
        return Spot
    end

    -- Get our spread calculation.
    Spot = self:CalculateSpread( CUserCMD, Spot, Cone, self.Require:GetRandomSeed( CUserCMD ) )

    Spot:Normalize( )

    return Spot
end