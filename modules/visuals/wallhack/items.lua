function Coffee.Visuals:Entities( )
    if ( not self.Config[ 'items_render' ] ) then 
        return
    end

    for k, Data in pairs( self.Items:Get( ) ) do 
        local Target, Class = Data.Target, Data.Class
        
        if ( not Target ) then 
            continue
        end

        local Distance = self.Client.Position:Distance2D( Target:GetPos( ) )

        if ( self.Config[ 'items_limit_distance' ] and Distance >= self.Config[ 'items_limit_distance_distance' ] ) then 
            continue
        end

        local isDormant = Target:IsDormant( )

        if ( not self.Config[ 'items_visualize_dormant' ] and isDormant ) then 
            continue 
        end

        local Color = isDormant and self.Config[ 'items_visualize_dormant_color' ] or self.Config[ 'items_render_color' ]

        local Position = Target:GetPos( ) + Target:OBBCenter( )
        local Data     = Position:ToScreen( )

        surface.SetFont( self:HandleFont( self.Config[ 'items_render_font' ] ) )
        surface.SetTextColor( Color )
        surface.SetTextPos( Data.x, Data.y ) 
        surface.DrawText( Class )

        if ( self.Config[ 'items_render_distance' ] ) then             
            local W, H = surface.GetTextSize( Class )

            surface.SetTextPos( Data.x, Data.y + H ) 
            surface.DrawText( math.Round( Distance ) .. 'hu' )
        end
    end
end