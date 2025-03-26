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

function Coffee.Overlay:Hitboxes( Bones, Decay, Color, IgnoreZ )
    self:Insert( 'Hitboxes', Decay, {
        Bones   = Bones,
        Color   = Color,
        IgnoreZ = IgnoreZ
    } )
end

function Coffee.Overlay:BoxAngles( Origin, Angles, Mins, Maxs, Decay, Color, IgnoreZ )
    self:Insert( 'Box', Decay, {
        Origin  = Origin,
        Angles  = Angles,
        Mins    = Mins,
        Maxs    = Maxs,
        Color   = Color,
        IgnoreZ = IgnoreZ
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

function Coffee.Overlay:Sphere( Origin, Radius, Steps, Decay, Color, Wireframe, IgnoreZ )
    self:Insert( 'Sphere', Decay, {
        Origin    = Origin,
        Radius    = Radius,
        Steps     = Steps,
        Wireframe = Wireframe,
        Color     = Color,
        IgnoreZ   = IgnoreZ
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

function Coffee.Overlay:Text( Origin, Text, Decay, Font, Color )
    self:Insert( 'Text', Decay, {
        Origin = Origin,
        Text   = Text,
        Font   = Font,
        Color  = Color
    } )
end

function Coffee.Overlay:Box( Origin, Mins, Maxs, Decay, Color, IgnoreZ )
    Maxs = Maxs or Vector( 2, 2, 2 )
    Mins = Mins or -Maxs

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

        cam.IgnoreZ( Object.IgnoreZ or false )

        render.SetColorMaterial( )

        if ( Name == 'Box' ) then 
            render.DrawBox( 
                Object.Origin, 
                Object.Angles, 
                Object.Mins, 
                Object.Maxs, 
                Object.Color 
            )
        elseif ( Name == 'Beam' ) then
            self.Beams:Render( 
                Object.Start, 
                Object.End, 
                Object.Speed, 
                Object.Amplitude, 
                Object.Twist, 
                Object.Cone, 
                Object.Segments, 
                Object.Width, 
                Object.firstColor, 
                Object.secondColor, 
                Object.Material 
            )
        elseif ( Name == 'Line' ) then 
            render.DrawLine( 
                Object.Start, 
                Object.End, 
                Object.Color, 
                Object.IgnoreZ 
            )
        elseif ( Name == 'Sphere' ) then 
            if ( Object.Wireframe ) then 
                render.DrawWireframeSphere( 
                    Object.Origin, 
                    Object.Radius, 
                    Object.Steps, 
                    Object.Steps, 
                    Object.Color, 
                    Object.IgnoreZ 
                )
            else
                render.DrawSphere( 
                    Object.Origin, 
                    Object.Radius, 
                    Object.Steps, 
                    Object.Steps, 
                    Object.Color 
                )
            end
        elseif ( Name == 'Text' ) then 
            cam.Start2D( )
                local Origin = Object.Origin:ToScreen( )
            
                surface.SetFont( Object.Font )
                surface.SetTextColor( Object.Color )
                surface.SetTextPos( Origin.x, Origin.y ) 
                surface.DrawText( Object.Text )
            cam.End2D( )
        elseif ( Name == 'Hitboxes' ) then 
            for k, Bones in ipairs( Object.Bones ) do 
                render.DrawWireframeBox( 
                    Bones.Origin, 
                    Bones.Angles, 
                    Bones.Mins, 
                    Bones.Maxs, 
                    Object.Color, 
                    not Object.IgnoreZ 
                )
            end
        end
    end

    cam.End3D( )
end

Coffee.Hooks:New( 'PostDrawEffects', Coffee.Overlay.Render, Coffee.Overlay )