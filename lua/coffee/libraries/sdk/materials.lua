Coffee.Materials = { 
    Disired = {
        [ 'Normal' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'models/debug/debugwhite',
                [ '$nocull' ] = 1,
            }
        },

        [ 'Pearlescent' ] = {    
            'UnLitGeneric',
            {
                [ '$basetexture' ] = 'detail/detail_noise1',
                [ '$envmap' ] = 'shadertest/cubedemo'
            }
        },

        [ 'Flat' ] = {
            'UnLitGeneric',
            {
                [ '$basetexture' ] = 'models/debug/debugwhite',
                [ '$nocull' ] = 1
            }
        },

        [ 'Wireframe' ] = {
            'Wireframe',
            {
                [ '$model' ] = 1
            }
        },

        [ 'Metal' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'models/debug/debugwhite',
                [ '$bumpmap' ] = 'vgui/white_additive',
                [ '$nocull' ] = 1,       
                [ '$envmap' ] = 'env_cubemap',
                [ '$envmaptint' ] = '[ .5 .5 .5 ]',
                [ '$selfillum' ] = 0,
            }
        },

        [ 'Cloud' ] = {
            'UnLitGeneric',
            {
                [ '$basetexture' ] = 'shadertest/cloud',
                [ '$envmap' ] = 'shadertest/cloud',
                
                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.60,
                        [ 'textureScrollAngle' ] = 60.0
                    }
                }
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
                [ '$selfIllumFresnelMinMaxExp' ] = '[ 0 1 2 ]',
                [ '$selfillumtint' ] = '[ 0 0 0 ]'
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
                [ '$selfIllumFresnelMinMaxExp' ] = '[ 0 1 2 ]',
                [ '$selfillumtint' ] = '[ 0 0 0 ]',
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
                [ '$basetexture' ] = 'models/props_combine/stasisfield_beam',
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

        [ 'Hue' ] = {  
            'Refract',
            {
                [ '$basetexture' ] = 'particle/warp_rain_normal',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$envmap' ] = 'env_cubemap',
                [ '$model' ] = 1,
            }
        },

        [ 'Cracked' ] = {
            'Refract',
            {
                [ '$basetexture' ] = 'effects/flashlight/caustics',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$envmap' ] = 'env_cubemap',
                [ '$model' ] = 1,
            }
        },

        [ 'Refracted' ] = {
            'Refract',
            {
                [ '$basetexture' ] = 'models/shadertest/shader4',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$envmap' ] = 'env_cubemap',
                [ '$model' ] = 1,
            }
        },

        [ 'Animated Portal' ] = {
            'UnlitTwoTexture',
            {
                [ '$basetexture' ] = 'models/props_combine/portalball001_sheet',
                [ '$texture2' ] = 'models/props_combine/portalball001b_sheet',
                [ '$model' ] = 1,
                [ '$additive' ] = 1,
                [ '$nocull' ] = 1,
                [ '$selfillum' ] = 1,
                [ '$selfIllumFresnel' ] = 1,
                [ '$selfIllumFresnelMinMaxExp' ] = '[0 1 4]',
                [ '$selfillumtint' ] = '[0 0 0]',
                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'texturescrollvar' ] = '$basetexturetransform',
                        [ 'texturescrollrate' ] = 0.2,
                        [ 'texturescrollangle' ] = 60,
                    }
                }
            }
        },

        [ 'Animated Highlight Wireframe' ] = {
            'VertexLitGeneric',	
            {
                [ '$basetexture' ] = 'shadertest/cloud',
                [ '$alpha' ] = 1,
                [ '$additive' ] = 1,
                [ '$selfillum' ] = 1,
                [ '$wireframe' ] = 1,
                [ '$ignorez' ] = 0,
                [ '$angle' ] = 90,
                [ '$texturescrollrate' ] = 0.25,
                [ '$texturescrollangle' ] = 180,
                [ '$texturescrollinput' ] = 25,
                [ '$devidebyonehundred' ] = 100,
                [ '$color' ] = '[ 1 1 1]',
                [ '$translate' ] = '[ 0.0 0.0 ]',
                [ '$centervar' ] = '[ -0.5 -0.5 ]',
                [ '$scalevar' ] = '[ 1.0 1.0 ]',

                [ 'Proxies' ] = {
                    [ 'Divide' ] = {
                        [ 'srcVar1' ] = '$texturescrollinput',
                        [ 'srcVar2' ] = '$devidebyonehundred',
                        [ 'resultVar' ] = '$texturescrollrate',
                    },
                    
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$translate',
                        [ 'textureScrollRate' ] = '$texturescrollrate',
                        [ 'textureScrollAngle' ] = '$texturescrollangle',
                    },
                    
                    [ 'TextureTransform' ] = {
                        [ 'translateVar' ] = '$translate',
                        [ 'scalevar' ] = '$scalevar',
                        [ 'rotateVar' ] = '$angle',
                        [ 'centerVar' ] = '$centervar',
                        [ 'resultVar' ] = '$basetexturetransform',
                    },
                }
            }
        },

        [ 'Animated Spawn Effect' ] = {
            'VertexLitGeneric',	
            {
                [ '$basetexture' ] = 'models/spawn_effect',
                [ '$alpha' ] = 1,
                [ '$additive' ] = 1,
                [ '$selfillum' ] = 1,
                [ '$wireframe' ] = 1,
                [ '$ignorez' ] = 0,
                [ '$angle' ] = 90,
                [ '$scaleinput' ] = 100,
                [ '$texturescrollrate' ] = 0.25,
                [ '$texturescrollangle' ] = 180,
                [ '$texturescrollinput' ] = 25,
                [ '$devidebyonehundred' ] = 100,
                [ '$color' ] = '[ 1 1 1 ]',
                [ '$translate' ] = '[ 0.0 0.0 ]',
                [ '$centervar' ] = '[ -0.5 -0.5 ]',
                [ '$scalevar' ] = '[ 1.0 1.0 ]',

                [ 'Proxies' ] = {
                    [ 'Divide' ] = {
                        [ 'srcVar1' ] = '$texturescrollinput',
                        [ 'srcVar2' ] = '$devidebyonehundred',
                        [ 'resultVar' ] = '$texturescrollrate',
                    },
                    
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$translate',
                        [ 'textureScrollRate' ] = '$texturescrollrate',
                        [ 'textureScrollAngle' ] = '$texturescrollangle',
                    },
                    
                    [ 'TextureTransform' ] = {
                        [ 'translateVar' ] = '$translate',
                        [ 'scalevar' ] = '$scalevar',
                        [ 'rotateVar' ] = '$angle',
                        [ 'centerVar' ] = '$centervar',
                        [ 'resultVar' ] = '$basetexturetransform',
                    },
                }
            }
        },

        [ 'Animated Water' ] = {
            'Refract',
            {
                [ '$model' ] = 1,
                [ '$refractamount' ] = 0.2,
                [ '$refracttint' ] = '[ 250 250 250 ]',
                [ '$scale' ] = '[ 1 1 ]',
                [ '$dudvmap' ] = 'models/shadertest/shieldnoise0_dudv',
                [ '$normalmap' ] = 'models/shadertest/shieldnoise0_normal',
                [ '$surfaceprop' ] = 'water',
                [ '$bumpframe' ] = 0,
                [ '$nocull' ] = 1,
                [ '$envmap' ] = 'env_cubemap',
                [ '$envmaptint' ] = '[ 1 1 1 ]',

                [ 'Proxies' ] =  {
                    [ 'AnimatedTexture' ] = {
                        [ 'animatedtexturevar' ] = '$normalmap',
                        [ 'animatedtextureframenumvar' ] = '$bumpframe',
                        [ 'animatedtextureframerate' ] = 29.00
                    }
                }
            }
        },

        [ 'Animated Teleport' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'effects/tp_eyefx/tpeyefx_',
                [ '$texturescrollrate' ] = 0.60,
                [ '$additive' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = '$texturescrollrate',
                        [ 'textureScrollAngle' ] = 55
                    },

                    [ 'Sine' ] = {
                        [ 'sinePeriod' ] = 1000,
                        [ 'sineMin' ] = 0.75,
                        [ 'sineMax' ] = 0.90,
                        [ 'timeOffset' ] = 0,
                        [ 'resultVar' ] = '$texturescrollrate'
                    }
                }
            }
        },

        [ 'Animated Plasma' ] = 'models/effects/comball_sphere',
        [ 'Physbeam' ]        = 'trails/physbeam',
    },

    Cache = { }
}

function Coffee.Materials:Get( Name, IgnoreZ, Color )
    local Material = self.Cache[ IgnoreZ and Name .. 'IgnoreZ' or Name ]

    if ( Color ) then 
        Material:SetVector( '$refracttint', Vector( Color.r / 255, Color.g / 255, Color.b / 255 ) )
    end

    return Material
end

function Coffee.Materials:CreateMaterial( Name, Shader, Data )
    if ( not Data ) then 
        self.Cache[ Name ] = Material( Shader )
        return
    end

    self.Cache[ Name ] = CreateMaterial( Name..math.random(1,10000), Shader, Data )
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