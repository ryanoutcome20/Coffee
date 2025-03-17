Coffee.Visuals.Sky = {
    Materials = Coffee.Materials,
    Config = Coffee.Config,

    Directions = { 'bk', 'dn', 'ft', 'lf', 'rt', 'up' },

    Restored = true,
    Last     = ''
}


function Coffee.Visuals.Sky:Grab( ENT )
    self.Cache = self.Cache or { 
        Top        = ENT:GetTopColor( ),
        Bottom     = ENT:GetBottomColor( ),
        fadeBias   = ENT:GetFadeBias( ),
        HDR        = ENT:GetHDRScale( ),
        
        Layers    = ENT:GetStarLayers( ),
        Draw      = ENT:GetDrawStars( ),
        Texture   = ENT:GetStarTexture( ),
        Speed     = ENT:GetStarSpeed( ),
        starFade  = ENT:GetStarFade( ),
        starScale = ENT:GetStarScale( ),

        Intensity = ENT:GetDuskIntensity( ),
        duskScale = ENT:GetDuskScale( ),
        duskColor = ENT:GetDuskColor( ),

        Size      = ENT:GetSunSize( ),
        sunColor  = ENT:GetSunColor( )
    }
end

function Coffee.Visuals.Sky:Restore( ENT )
    if ( self.Restored or not self.Cache ) then 
        return
    end

	ENT:SetTopColor( self.Cache.Top )
	ENT:SetBottomColor( self.Cache.Bottom )
	ENT:SetFadeBias( self.Cache.fadeBias )
	ENT:SetHDRScale( self.Cache.HDR )

	ENT:SetDrawStars( self.Cache.Draw )
    ENT:SetStarLayers( self.Cache.Layers )
	ENT:SetStarTexture( self.Cache.Texture )
	ENT:SetStarSpeed( self.Cache.Speed )
	ENT:SetStarFade( self.Cache.starFade )
	ENT:SetStarScale( self.Cache.starScale )

	ENT:SetDuskIntensity( self.Cache.Intensity )
	ENT:SetDuskScale( self.Cache.duskScale )
	ENT:SetDuskColor( self.Cache.duskColor )

	ENT:SetSunSize( self.Cache.Size )
	ENT:SetSunColor( self.Cache.sunColor )

    self.Restored = true
end

function Coffee.Visuals.Sky:SetBasicSkybox( Name )
    if ( self.Last == Name ) then 
        return
    end
    
    for k, Direction in pairs( self.Directions ) do 
        local Texture = Material( string.format( 'skybox/%s%s', self.Sky, Direction ) )

        if ( Texture ) then 
            Texture:SetTexture( '$basetexture', Name .. Direction )
        end
    end

    self.Last = Name
end

function Coffee.Visuals.Sky:Handler( )
    if ( not self.Sky ) then 
        self.Sky = ents.FindByClass( 'env_skypaint' )[ 1 ]
        
        if ( not self.Sky ) then 
            self.Sky = GetConVar( 'sv_skyname' ):GetString( )
        end
    end

    if ( not self.Config[ 'world_sky' ] ) then 
        return self:Restore( self.Sky )
    end

    if ( isstring( self.Sky ) ) then 
        return self:SetBasicSkybox( self.Config[ 'world_sky_basic' ] )
    end

    self:Grab( self.Sky )
    self:Restore( self.Sky )

    local ENT = self.Sky

	ENT:SetTopColor( self.Materials:GetColoredVector( self.Config[ 'world_sky_top' ] ) )
	ENT:SetBottomColor( self.Materials:GetColoredVector( self.Config[ 'world_sky_bottom' ] ) )
	ENT:SetFadeBias( self.Config[ 'world_sky_fade_bias' ] )
	ENT:SetHDRScale( self.Config[ 'world_sky_hdr' ] )

	ENT:SetDrawStars( self.Config[ 'world_sky_stars' ] )
    ENT:SetStarLayers( self.Config[ 'world_sky_stars_density' ] )
	ENT:SetStarTexture( self.Config[ 'world_sky_stars_texture' ] )
	ENT:SetStarSpeed( self.Config[ 'world_sky_stars_speed' ] / 60 )
	ENT:SetStarFade( self.Config[ 'world_sky_stars_fade' ] )
	ENT:SetStarScale( self.Config[ 'world_sky_stars_scale' ] )

    if ( self.Config[ 'world_sky_dusk' ] ) then 
        ENT:SetDuskIntensity( self.Config[ 'world_sky_dusk_intensity' ] / 10 )
        ENT:SetDuskScale( self.Config[ 'world_sky_dusk_scale' ] )
        ENT:SetDuskColor( self.Materials:GetColoredVector( self.Config[ 'world_sky_dusk_color' ] ) )
    else
        ENT:SetDuskIntensity( 0 )
        ENT:SetDuskScale( 0 )
    end

    if ( self.Config[ 'world_sky_sun' ] ) then 
        ENT:SetSunSize( self.Config[ 'world_sky_sun_size' ] / 10 )
        ENT:SetSunColor( self.Materials:GetColoredVector( self.Config[ 'world_sky_sun_color' ] ) )
    else
        ENT:SetSunSize( 0 )
    end

    self.Restored = false 
end