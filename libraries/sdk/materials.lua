Coffee.Materials = { 
    Disired = {
        [ 'Normal' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'models/debug/debugwhite',
                [ '$nocull' ] = 1
            }
        },

        [ 'Flat' ] = {
            'UnLitGeneric',
            {
                [ '$basetexture' ] = 'models/debug/debugwhite',
                [ '$nocull' ] = 1
            }
        },

        [ 'Glow' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'vgui/white_additive',
                [ '$bumpmap' ] = 'vgui/white_additive',
                [ '$model' ] = 1,
                [ '$nocull' ] = 1,
                [ '$selfillum' ] = 1,
                [ '$selfIllumFresnel' ] = 1,
                [ '$selfIllumFresnelMinMaxExp' ] = '[0 1 4]',
                [ '$selfillumtint' ] = '[0 0 0]',
            }
        },

        [ 'Outline' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'vgui/white_additive',
                [ '$bumpmap' ] = 'vgui/white_additive',
                [ '$model' ] = 1,
                [ '$nocull' ] = 1,
                [ '$additive' ] = 1,
                [ '$selfillum' ] = 1,
                [ '$selfIllumFresnel' ] = 1,
                [ '$selfIllumFresnelMinMaxExp' ] = '[0 1 0.75]',
                [ '$selfillumtint' ] = '[0 0 0]',
            }
        },
        
        [ 'Wireframe' ] = {
            'Wireframe',
            {
                [ '$model' ] = 1
            }
        },

        [ 'Animated Wireframe' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'sprites/light_glow01',
                [ '$model' ] = 1,
                [ '$nodecal' ] = 1,
                [ '$additive' ] = 1,
                [ '$nocull' ] = 1,
                [ '$wireframe' ] = 1,
                
                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.60,
                        [ 'textureScrollAngle' ] = 90.0
                    }
                }
            }
        },

        [ 'Stars' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = "models/props_combine/stasisfield_beam",
                [ '$nodecal' ] = 1,
                [ '$model' ] = 1,
                [ '$additive' ] = 1,
                [ '$nocull' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'texturescrollvar' ] = '$basetexturetransform',
                        [ 'texturescrollrate' ] = 0.65,
                        [ 'texturescrollangle' ] = 90,
                    }
                },
            }
        },

        [ 'Animated Plasma' ] = 'models/effects/comball_sphere',
        [ 'Metal' ]           = 'models/shiny',
        [ 'Physbeam' ]        = 'trails/physbeam',
    },

    Cache = { }
}

function Coffee.Materials:Get( Name, IgnoreZ )
    return self.Cache[ IgnoreZ and Name .. 'IgnoreZ' or Name ]
end

function Coffee.Materials:CreateMaterial( Name, Shader, Data )
    if ( not Data ) then 
        self.Cache[ Name ] = Material( Shader )
        return
    end

    self.Cache[ Name ] = CreateMaterial( Name, Shader, Data )
end

function Coffee.Materials:Init( )
    for k,v in pairs( self.Disired ) do
        if ( isstring( v ) ) then
            self:CreateMaterial( k, v ) 
            continue
        end 

        self:CreateMaterial( k, v[ 1 ], v[ 2 ] )

        v[ 2 ][ '$ignorez' ] = 1

        self:CreateMaterial( k .. 'IgnoreZ', v[ 1 ], v[ 2 ] )
    end
end

Coffee.Materials:Init( )