local Size     = CreateClientConVar( 'zoomrt_size', 512 ):GetInt( )
local Enabled  = CreateClientConVar( 'zoomrt', 0 )
local Locked   = CreateClientConVar( 'zoomrt_lock', 0 )

local Texture  = GetRenderTarget( 'ZoomRT', Size, Size )
local ZoomRT   = CreateMaterial( 'ZoomRT', 'UnlitGeneric', {
	['$basetexture'] = Texture:GetName( )
} )

local Hit;
local Eye;

hook.Add( 'HUDPaint', 'ZoomRT', function( )
    if ( not Enabled:GetBool( ) ) then 
        return
    end

    if ( not Locked:GetBool( ) ) then
        Eye = LocalPlayer( ):EyeAngles( )
        Hit = LocalPlayer( ):GetEyeTrace( ).HitPos - ( Eye:Forward( ) * 40 )
    end

    render.PushRenderTarget( Texture )
    cam.Start2D( )

        render.RenderView( {
            origin = Hit,
            angles = Eye
        } )

    cam.End2D( )
    render.PopRenderTarget( )

    surface.SetDrawColor( 255, 0, 0 )
    surface.SetMaterial( Material( 'vgui/gradient-l' ) )
    surface.DrawTexturedRect( 23, 23, Size, Size + 4 )

    surface.SetDrawColor( 0, 0, 255 )
    surface.SetMaterial( Material( 'vgui/gradient-r' ) )
    surface.DrawTexturedRect( 27, 23, Size, Size + 4 )

	surface.SetDrawColor( color_white )
	surface.SetMaterial( ZoomRT )
	surface.DrawTexturedRect( 25, 25, Size, Size )
end )