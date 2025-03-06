function Coffee.Bots:InsertPoint( )
    table.insert( self.Points, self.Client.Position )
end

function Coffee.Bots:RemovePoint( First )
    table.remove( self.Points, First and 1 or #self.Points )
end

function Coffee.Bots:ClearPoints( )
    table.Empty( self.Points )
end

function Coffee.Bots:FindPoint( )
    local Point = self.Points[ self.Active + 1 ]

    if ( not Point ) then 
        return
    end

    local Target = ( Point - self.Client.Position )

    if ( Target:Length2D( ) < 1 ) then 
        self.Active = ( self.Active + 1 ) % #self.Points
    end

    return Target
end

function Coffee.Bots:RenderPoints( )
    if ( not self.Config[ 'miscellaneous_point_bot_render' ] ) then 
        return
    end

    local Color  = self.Config[ 'miscellaneous_point_bot_render_color' ]
    local Number = self.Config[ 'miscellaneous_point_bot_render_number' ]

    for i = 1, #self.Points do 
        local Point = self.Points[ i ]

        local Adjusted = Vector( Point.x, Point.y, Point.z + 10 )

        self.Overlay:Box( Adjusted, nil, nil, false, Color, true )

        if ( Number ) then 
            self.Overlay:Text( Adjusted, i, false, 'DebugOverlay', self.Colors.White )
        end
    end
end

function Coffee.Bots:Point( CUserCMD )
    if ( not self.Config[ 'miscellaneous_point_bot' ] or not self.Menu:Keydown( 'miscellaneous_point_bot_keybind' ) ) then 
        return
    end

    local Best = self:FindPoint( )

    if ( not Best ) then 
        return
    end

    CUserCMD:SetForwardMove( 10000 )
    CUserCMD:SetSideMove( 0 )

    CUserCMD:SetViewAngles( Best:Angle( ) )
end

Coffee.Hooks:New( 'RenderScreenspaceEffects', Coffee.Bots.RenderPoints, Coffee.Bots )