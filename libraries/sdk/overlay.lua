Coffee.Overlay = { 
    Beams = Coffee.Beams,

    Cache = { }
}

function Coffee.Overlay:Insert( Object, Decay, Data )
    table.insert( self.Cache, {
        Object = Object,
        Decay  = Decay,
        Data   = Data,
        Time   = CurTime( )
    } )
end

function Coffee.Overlay:BoxAngles( Origin, Angles, Mins, Maxs, Decay, Color, IgnoreZ )
    self:Insert( 'Box', Decay, {
        Origin = Origin,
        Angles = Angles,
        Mins   = Mins,
        Maxs   = Maxs,
        Color  = Color
    } )
end

function Coffee.Overlay:Beam( Start, End, Decay, Width, Speed, Amplitude, Twist, Cone, Segments, Material, firstColor, secondColor, IgnoreZ )
    self:Insert( 'Beam', Decay, {
        Start       = Start,
        End         = End,
        Width       = Width,
        Speed       = Speed,
        Amplitude   = Amplitude,
        Twist       = Twist,
        Cone        = Cone,
        Segments    = Segments,
        Material    = Material,
        firstColor  = firstColor,
        secondColor = secondColor,
        IgnoreZ     = IgnoreZ
    } )    
end

function Coffee.Overlay:Line( Start, End, Decay, Color, IgnoreZ )
    self:Insert( 'Line', Decay, {
        Start   = Start,
        End     = End,
        Color   = Color,
        IgnoreZ = IgnoreZ
    } )
end

function Coffee.Overlay:Box( Origin, Mins, Maxs, Decay, Color, IgnoreZ )
    self:BoxAngles( Origin, angle_zero, Mins, Maxs, Decay, Color, IgnoreZ )
end

function Coffee.Overlay:Render( )
    cam.Start3D( )

    local Time = CurTime( )

    for k, Index in ipairs( self.Cache ) do
        if ( not isbool( Index.Decay ) ) then   
            if ( Index.Time == nil or Index.Time + Index.Decay < Time ) then 
                table.remove( self.Cache, k )
                continue 
            end
        else 
            if ( Index.Decay ) then 
                table.remove( self.Cache, k )
                continue 
            end

            Index.Decay = true
        end

        local Name, Object = Index.Object, Index.Data

        cam.IgnoreZ( Object.IngoreZ or false )

        render.SetColorMaterial( )

        if ( Name == 'Box' ) then 
            render.DrawBox( Object.Origin, Object.Angles, Object.Mins, Object.Maxs, Object.Color )
        elseif ( Name == 'Beam' ) then
            self.Beams:Render( Object.Start, Object.End, Object.Speed, Object.Amplitude, Object.Twist, Object.Cone, Object.Segments, Object.Width, Object.firstColor, Object.secondColor, Object.Material )
        elseif ( Name == 'Line' ) then 
            render.DrawLine( Object.Start, Object.End, Object.Color, Object.IgnoreZ )
        end
    end

    cam.End3D( )
end

Coffee.Hooks:New( 'RenderScreenspaceEffects', Coffee.Overlay.Render, Coffee.Overlay )

concommand.Add( 'drawbox', function( )
    local Eye = LocalPlayer():GetEyeTrace( )

    Coffee.Overlay:Box( Eye.HitPos, Vector( 0, 0, 0 ), Vector( 2, 2, 2 ), 3, Color( 255, 0, 0, 180 ) )
    -- Coffee.Overlay:Line( Eye.StartPos, Eye.HitPos, 3, Color( 0, 0, 255, 180 ), false )
    -- Coffee.Overlay:Beam( Eye.StartPos, Eye.HitPos, 3, 25, Material( 'trails/laser' ), Color( 0, 0, 255, 180 ), false )
    Coffee.Overlay:Beam( Eye.StartPos, Eye.HitPos, 3, 2, 0.5, 0.2, 1000, 2, 25, Material( 'trails/physbeam' ), Color(255,0,0), Color(0,255,0) )
end )