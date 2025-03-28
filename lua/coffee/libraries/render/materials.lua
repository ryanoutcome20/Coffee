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
                [ '$supressedenginelighting' ] = 1,
                [ '$selfIllumFresnelMinMaxExp' ] = '[ 0 1 2 ]',
                [ '$selfillumtint' ] = '[ 0 0 0 ]',
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
                [ '$supressedenginelighting' ] = 1,
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
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.65,
                        [ 'textureScrollAngle' ] = 90,
                    }
                },
            }
        },

        [ 'Hue' ] = {  
            'Refract',
            {
                [ '$additive' ] = 1,
                [ '$basetexture' ] = 'particle/warp_rain_normal',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$envmap' ] = 'env_cubemap',
                [ '$envmaptint ' ] = '[ 0 0 0 ]',
                [ '$model' ] = 1,
            }
        },

        [ 'Cracked' ] = {
            'Refract',
            {
                [ '$additive' ] = 1,
                [ '$basetexture' ] = 'effects/flashlight/caustics',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$envmap' ] = 'env_cubemap',
                [ '$envmaptint ' ] = '[ 0 0 0 ]',
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
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.2,
                        [ 'textureScrollAngle' ] = 60,
                    }
                }
            }
        },

        [ 'Animated Shield' ] = {
            'Refract',
            {
                [ '$model' ] = 1,
                [ '$refractamount' ] = 0.05,
                [ '$bumpframe' ] = 0,
                [ '$nocull' ] = 1,
                [ '$scrollangle' ] = 90,
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$dudvmap' ] = 'models/effects/com_shield001a_dudv',
                [ '$normalmap' ] = 'models/effects/com_shield001a_normal',

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$bumptransform',
                        [ 'textureScrollRate' ] = 0.05,
                        [ 'textureScrollAngle' ] = '$scrollangle'
                    },

                    [ 'Sine' ] = {
                        [ 'sinePeriod' ] = 25,
                        [ 'sineMin' ] = 85,
                        [ 'sineMax' ] = 90,
                        [ 'resultVar' ] = '$scrollangle'
                    }
                }
            }
        },

        [ 'Animated Fenceglow' ] = {
            'UnlitTwoTexture',
            {
                [ '$nocull' ] = 1,
                [ '$nodecal' ] = 1,
                [ '$additive' ] = 1,
                [ '$basetexture' ] = 'models/props_combine/combine_fenceglow',
                [ '$texture2' ] = 'sprites/smoke',

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$texture2transform',
                        [ 'textureScrollRate' ] = -0.5,
                        [ 'textureScrollAngle' ] = 0
                    }
                }
            }
        },

        [ 'Animated Breathing' ] = {
            'Refract',
            {
                [ '$additive' ] = 1,
                [ '$basetexture' ] = 'sprites/glow01',
                [ '$normalmap' ] = 'gm_construct/water_13_normal',
                [ '$refracttexture' ] = '_rt_WaterRefraction',
                [ '$reflecttexture' ] = '_rt_WaterReflection',
                [ '$dudvmap' ] = 'gm_construct/water_13_dudv',
                [ '$refracttint' ] = '[ 0 0 0 ]',
                [ '$model' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$bumptransform',
                        [ 'textureScrollRate' ] = 0.05,
                        [ 'textureScrollAngle' ] = 90,
                    },

                    [ 'Sine' ] = {
                        [ 'sinePeriod' ] = 2,
                        [ 'sineMin' ] = 0,
                        [ 'sineMax' ] = 4,
                        [ 'resultVar' ] = '$refractamount'
                    }
                }
            }
        },

        [ 'Animated Dots' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'models/props_lab/warp_sheet',
                [ '$alpha' ] = 1,
                [ '$additive' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.45,
                        [ 'textureScrollAngle' ] = 60,
                    },
                }
            }
        },

        [ 'Animated Wireframe Dots' ] = {
            'VertexLitGeneric',
            {
                [ '$basetexture' ] = 'models/props_lab/warp_sheet',
                [ '$alpha' ] = 1,
                [ '$additive' ] = 1,
                [ '$wireframe' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = 0.45,
                        [ 'textureScrollAngle' ] = 60,
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
                [ '$color' ] = '[ 1 1 1 ]',

                [ '$textureScrollRate' ] = 0.45,

                [ '$translate' ] = '[ 0.0 0.0 ]',
                [ '$centervar' ] = '[ -0.5 -0.5 ]',
                [ '$scalevar' ] = '[ 5 5 ]',

                [ 'Proxies' ] = {
                    [ 'Divide' ] = {
                        [ 'srcVar1' ] = 25,
                        [ 'srcVar2' ] = 100,
                        [ 'resultVar' ] = '$textureScrollRate',
                    },
                    
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$translate',
                        [ 'textureScrollRate' ] = '$textureScrollRate',
                        [ 'textureScrollAngle' ] = 80,
                    },
                    
                    [ 'TextureTransform' ] = {
                        [ 'translateVar' ] = '$translate',
                        [ 'scalevar' ] = '$scalevar',
                        [ 'rotateVar' ] = 90,
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
                [ '$refracttint' ] = '[ 1 1 1 ]',
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
                [ '$textureScrollRate' ] = 0.60,
                [ '$additive' ] = 1,

                [ 'Proxies' ] = {
                    [ 'TextureScroll' ] = {
                        [ 'textureScrollVar' ] = '$basetexturetransform',
                        [ 'textureScrollRate' ] = '$textureScrollRate',
                        [ 'textureScrollAngle' ] = 55
                    },

                    [ 'Sine' ] = {
                        [ 'sinePeriod' ] = 1000,
                        [ 'sineMin' ] = 0.75,
                        [ 'sineMax' ] = 0.90,
                        [ 'resultVar' ] = '$textureScrollRate'
                    }
                }
            }
        },

        [ 'Animated Plasma' ] = 'models/effects/comball_sphere',
        [ 'Physbeam' ]        = 'trails/physbeam',
        [ 'Laser' ]           = 'trails/laser',
        [ 'Lightning' ]       = 'trails/electric',
        [ 'Plasma' ]          = 'trails/plasma',
        [ 'LOL!' ]            = 'trails/lol',
        [ 'Smoke' ]           = 'trails/smoke',
        [ 'Beam' ]            = 'sprites/tp_beam001'
    },

    Cache = { }
}

function Coffee.Materials:Get( Name, IgnoreZ, Color, secondaryColor )
    local Material = self.Cache[ IgnoreZ and Name .. 'IgnoreZ' or Name ]

    if ( Color ) then 
        local Tint = self:GetColoredVector( Color )

        Material:SetVector( '$refracttint', Tint )
        Material:SetVector( '$color', Tint )
    end

    if ( secondaryColor ) then 
        local Tint = self:GetColoredVector( secondaryColor )
        
        Material:SetVector( '$envmaptint', Tint )
        Material:SetVector( '$selfillumtint', Tint )
        Material:SetVector( '$color2', Tint )

        local Ranges = Material:GetVector( '$selfIllumFresnelMinMaxExp' ) 

        if ( Ranges ) then 
            Ranges.y = secondaryColor.a / 255

            Material:SetVector( '$selfIllumFresnelMinMaxExp', Ranges )
        end
    end

    return Material
end

function Coffee.Materials:GetColoredVector( Color )
    return Vector( Color.r / 255, Color.g / 255, Color.b / 255 )
end

function Coffee.Materials:GetEngineLighting( Material )
    return tobool( Material:GetInt( '$supressedenginelighting' ) )
end

function Coffee.Materials:CreateMaterial( Name, Shader, Data )
    if ( not Data ) then 
        self.Cache[ Name ] = Material( Shader )
        return
    end

    self.Cache[ Name ] = CreateMaterial( Name..math.random(1,100000), Shader, Data )
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