Coffee.Ragebot.TFA = {
    sv_tfa_spread_multiplier    = GetConVar( 'sv_tfa_spread_multiplier' ),
    sv_tfa_recoil_legacy        = GetConVar( 'sv_tfa_recoil_legacy' ),
    sv_tfa_recoil_mul_p         = GetConVar( 'sv_tfa_recoil_mul_p' ),
    sv_tfa_recoil_mul_y         = GetConVar( 'sv_tfa_recoil_mul_y' ),

    sv_tfa_damage_mult_min      = GetConVar( 'sv_tfa_damage_mult_min' ),
    sv_tfa_damage_mult_max      = GetConVar( 'sv_tfa_damage_mult_max' ),
}

function Coffee.Ragebot.TFA:RunTrace( Record, Matrix, Autowall, Minimum )
    local Trace = util.TraceLine( { start = self.Client.EyePos, endpos = Matrix, filter = { self.Client.Local, Record.Target }, mask = MASK_SHOT } )

    return Trace.Fraction == 1
end

function Coffee.Ragebot.TFA:Damage( Record, Group )
    local SWEP = self.Client.Weapon

    if ( not SWEP.ConDamageMultiplier or not SWEP.GetStatL ) then 
        return true
    end

    local Damage = SWEP.ConDamageMultiplier * SWEP:GetStatL("Primary.Damage")
    
    Damage = Damage * util.SharedRandom( 
        'TFA_Bullet_RandomDamageMult' .. CurTime( ), 
        self.sv_tfa_damage_mult_min:GetFloat( ), 
        self.sv_tfa_damage_mult_max:GetFloat( ), 
        SWEP:EntIndex( )
    )

    Damage = self:GetWeaponDamageScale( Damage, SWEP:GetPrimaryAmmoType( ), Group )

    if ( self.Config[ 'aimbot_minimum_damage_damage' ] <= Damage ) then 
        return true
    end
end

function Coffee.Ragebot.TFA:CalculateRecoil( CUserCMD, Spot, SWEP )
    if ( SWEP.Base == 'tfa_rust_recoilbase' ) then 
        return SWEP.RecoilAng 
    end

    local Recoil = self.Client.Local:GetViewPunchAngles( )

    if ( not self.sv_tfa_recoil_legacy:GetBool( ) ) then 
        Recoil.x = SWEP:GetViewPunchP( )
        Recoil.y = SWEP:GetViewPunchY( )
        Recoil.z = 0
    end 

    Recoil.x = Recoil.x * self.sv_tfa_recoil_mul_p:GetFloat( )
    Recoil.y = Recoil.y * self.sv_tfa_recoil_mul_y:GetFloat( )

    return Recoil
end

function Coffee.Ragebot.TFA:CalculateCompensation( CUserCMD, Spot, Recoil, Spread )
    if ( isvector( Spot ) ) then 
        Spot = Spot:Angle( )
    end

    -- The TFA pack that I was able to find doesn't used synced spread. Should probably
    -- go find TFA Redux and test on that instead.
    
    local SWEP = self.Client.Local:GetActiveWeapon( )

    if ( not SWEP or not SWEP:IsValid( ) ) then 
        return Spot
    end

    if ( Recoil or Spread ) then 
        return Spot - self:CalculateRecoil( CUserCMD, Spot, SWEP )
    end

    return Spot
end