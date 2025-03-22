Coffee.Draggables = {
    Records = Coffee.Records,
    Client  = Coffee.Client,
    Config  = Coffee.Config,
    Menu    = Coffee.Menu,

    Observers = { 
        [ OBS_MODE_IN_EYE ] = 'Firstperson',
        [ OBS_MODE_CHASE ]  = 'Thirdperson'
    },

    Panels = { }
}

function Coffee.Draggables:New( Name )
    self.Panels[ Name ] = self.Menu:GenerateDraggable( nil, Name, 125 * table.Count( self.Panels ), 5 )

    return self.Panels[ Name ]
end

function Coffee.Draggables:Get( Name )
    if ( self.Panels[ Name ] ) then 
        return self.Panels[ Name ]
    end

    return self:New( Name )
end

function Coffee.Draggables:Update(  )
    local Active = { }

    -- Get panels.
    local Spectators = self:Get( 'Spectators' )
    local Admins     = self:Get( 'Admins' )

    Spectators:ClearIndexes( )
    Admins:ClearIndexes( )

    -- Update spectators.
    Spectators:SetVisible( self.Config[ 'miscellaneous_spectator_list' ] )

    for k, Target in pairs( self.Records.Players ) do 
        if ( Target:GetObserverTarget( ) == self.Client.Local ) then 
            local Mode = self.Observers[ Target:GetObserverMode( ) ] or 'Other'
            
            table.insert( Active, string.format( '%s (%s)', Target:Name( ), Mode ) )
        end
    end

    table.sort( Active )

    Spectators:AddIndexes( Active )

    Active = { }

    -- Update admins. 
    Admins:SetVisible( self.Config[ 'miscellaneous_admin_list' ] )

    for k, Target in pairs( self.Records.Players ) do 
        if ( Target:IsAdmin( ) or Target:IsSuperAdmin( ) ) then 
            local Distance = 'Dormant'

            if ( not Target:IsDormant( ) ) then 
                Distance = math.Round( self.Client.Position:Distance2D( Target:GetPos( ) ) ) .. 'hu'
            end

            table.insert( Active, string.format( '%s (%s)', Target:Name( ), Distance ) )
        end
    end

    table.sort( Active )

    Admins:AddIndexes( Active )

    Active = { }
end

Coffee.Hooks:New( 'Tick', Coffee.Draggables.Update, Coffee.Draggables )