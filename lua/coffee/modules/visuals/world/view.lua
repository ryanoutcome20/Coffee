function Coffee.Visuals:Thirdperson( Origin, Angles )
    local Distance = Coffee.Config[ 'world_thirdperson_distance' ]

    if ( Coffee.Config[ 'world_thirdperson_interpolation' ] ) then 
        Distance = Lerp( ( CurTime( ) - self.prevTime ) / 4, self.prevDistance, Distance )
    end

    local Adjusted = Origin

    Adjusted = Adjusted - ( Angles:Forward( ) * Distance )
    Adjusted = Adjusted + ( Angles:Right( ) * Coffee.Config[ 'world_thirdperson_distance_right' ] )
    Adjusted = Adjusted + ( Angles:Up( ) * Coffee.Config[ 'world_thirdperson_distance_up' ] )

    if ( Coffee.Config[ 'world_thirdperson_collisions' ] ) then 
        local Trace = util.TraceLine( {
            start  = Origin,
            endpos = Adjusted,
            filter = self.Client.Local
        } )

        Adjusted = Trace.HitPos

        if ( Trace.Fraction != 1 ) then 
            Adjusted = Adjusted + Trace.HitNormal * 5
        end
    end

    self.prevDistance = Distance

    return Adjusted
end

function Coffee.Visuals:CalcView( ENT, Origin, Angles, FOV )
    local View = { }

    View.origin = Origin
    View.fov    = FOV
    View.angles = Angles
    
    if ( Coffee.Config[ 'world_thirdperson' ] and self.Menu:Keydown( 'world_thirdperson_keybind' ) ) then 
        View.origin = self:Thirdperson( Origin, Angles )
        View.drawviewer = true
    else 
        self.prevTime     = CurTime( )
        self.prevDistance = 0
    end
    
    if ( Coffee.Config[ 'world_fov' ] ) then 
        View.fov = Coffee.Config[ 'world_fov_amount' ]
    end

    if ( self.Ragebot:ShouldSilent( ) ) then 
        View.angles = self.Ragebot.Silent
    elseif ( Coffee.Config[ 'world_viewmodel' ] and Coffee.Config[ 'world_viewmodel_recoil' ] ) then 
        View.angles = View.angles - self.Client.Local:GetViewPunchAngles( )
    end

    return View
end

function Coffee.Visuals:CalcViewModelView( SWEP, Viewmodel, oldOrigin, oldAngle, Origin, Angle )
    local Update = false

    if ( Coffee.Config[ 'world_viewmodel' ] ) then 
        if ( Coffee.Config[ 'world_viewmodel_sway' ] ) then 
            local Delta = ( Origin - oldOrigin ) * ( Coffee.Config[ 'world_viewmodel_sway_scale' ] / 100 )
            
            Origin = oldOrigin + Delta
        end
        
        if ( Coffee.Config[ 'world_viewmodel_bob' ] ) then 
            local Delta = ( Angle - oldAngle ) * ( Coffee.Config[ 'world_viewmodel_bob_scale' ] / 100 )
            
            Angle = oldAngle + Delta
        end

        if ( Coffee.Config[ 'world_viewmodel_gamemode_view' ] ) then 
            Origin, Angle = GAMEMODE:CalcViewModelView( SWEP, Viewmodel, oldOrigin, oldAngle, Origin, Angle )
        end

        Update = true
    end

    if ( not Origin or not Angle ) then 
        return
    end

    if ( Coffee.Config[ 'world_offsets' ] ) then 
        Angle:RotateAroundAxis( Angle:Forward( ), Coffee.Config[ 'world_offsets_roll' ] )
        Angle:RotateAroundAxis( Angle:Right( ), Coffee.Config[ 'world_offsets_pitch' ] )
        Angle:RotateAroundAxis( Angle:Up( ), Coffee.Config[ 'world_offsets_yaw' ] )

        local Base = Coffee.Config[ 'world_offsets_base' ]

        if ( Base == 'Floor' ) then 
            Origin = self.Client.Position
        elseif ( Base == 'Eye' ) then 
            Origin = self.Client.Local:EyePos( )
        end

        Origin = Origin + Coffee.Config[ 'world_offsets_x' ] * Angle:Right( ) * 1
        Origin = Origin + Coffee.Config[ 'world_offsets_y' ] * Angle:Forward( ) * 1
        Origin = Origin + Coffee.Config[ 'world_offsets_z' ] * Angle:Up( ) * 1
        
        Update = true
    end

    if ( Coffee.Config[ 'world_viewmodel_visualize_aimbot' ] and self.Ragebot.currentAngle ) then 
        Angle  = self.Ragebot.currentAngle
        
        Update = true
    end

    if ( Update ) then 
        return Origin, Angle    
    end
end

Coffee.Hooks:New( 'CalcView', Coffee.Visuals.CalcView, Coffee.Visuals )
Coffee.Hooks:New( 'CalcViewModelView', Coffee.Visuals.CalcViewModelView, Coffee.Visuals )