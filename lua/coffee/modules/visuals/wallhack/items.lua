function Coffee.Visuals:Entities( )
    if ( not Coffee.Config[ 'items_render' ] ) then 
        return
    end

    for k, Data in pairs( self.Items:Get( ) ) do 
        local Target, Class = Data.Target, Data.Class
        
        if ( not Target ) then 
            continue
        end

        local Distance = self.Client.Position:Distance2D( Target:GetPos( ) )

        if ( Coffee.Config[ 'items_limit_distance' ] and Distance >= Coffee.Config[ 'items_limit_distance_distance' ] ) then 
            continue
        end

        local isDormant = Target:IsDormant( )

        if ( not Coffee.Config[ 'items_visualize_dormant' ] and isDormant ) then 
            continue 
        end

        local Color = isDormant and Coffee.Config[ 'items_visualize_dormant_color' ] or Coffee.Config[ 'items_render_color' ]

        local Position = Target:GetPos( ) + Target:OBBCenter( )
        local Data     = Position:ToScreen( )

        surface.SetFont( self:HandleFont( Coffee.Config[ 'items_render_font' ] ) )
        surface.SetTextColor( Color )
        surface.SetTextPos( Data.x, Data.y ) 
        surface.DrawText( Class )

        if ( Coffee.Config[ 'items_render_distance' ] ) then             
            local W, H = surface.GetTextSize( Class )

            surface.SetTextPos( Data.x, Data.y + H ) 
            surface.DrawText( math.Round( Distance ) .. 'hu' )
        end
    end
end