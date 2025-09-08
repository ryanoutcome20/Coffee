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

        if ( isDormant ) then 
            continue 
        end

		-- Get positions. 
		local Position = Target:GetPos( )
		local Mins, Maxs = Target:OBBMins( ), Target:OBBMaxs( )

        local Screen = Position:ToScreen( )

        self.Position = {
            X = Screen.x,
            Y = Screen.y
        }

        self.Position.H = Screen.y - ( Position + Vector( 0, 0, Maxs.z ) ):ToScreen( ).y
        self.Position.W = self.Position.H / 2

		-- Reset offsets.
		self.Offsets = { 
            [ 'Top' ] = 12,
            [ 'Bottom' ] = 4,
            [ 'Right' ] = 0,
            [ 'Left' ] = 0,
            
            [ 'Right Intrinsic' ] = 6,
            [ 'Left Intrinsic' ] = 6
        }
		
		-- Run our box ESP.
        if ( Coffee.Config[ 'items_box' ] ) then 
			cam.Start3D( )
				render.DrawWireframeBox( 
					Position, 
					Target:GetAngles(), 
					Mins, 
					Maxs, 
					Coffee.Config[ 'items_box_color' ], 
					true 
				)
			cam.End3D( )
        end

		-- Text.
        self:RenderText( Class, 'items_name' )
        self:RenderText( math.Round( Distance ) .. 'hu', 'items_distance' )		
		
    end
end