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

Coffee:LoadFile( 'lua/coffee/modules/visuals/draggables/bars.lua' )

function Coffee.Draggables:New( Name, Bar )
    self.Panels[ Name ] = self.Menu:GenerateDraggable( 
        nil, 
        Name, 
        Bar and 0 or 125 * table.Count( self.Panels ), 
        Bar and 45 * table.Count( self.Panels ) or 5 
    )

    return self.Panels[ Name ]
end

function Coffee.Draggables:Get( Name, Bar )
    if ( self.Panels[ Name ] ) then 
        return self.Panels[ Name ]
    end

    return self:New( Name, Bar )
end

function Coffee.Draggables:Update( )
    -- Get panels.
    local Spectators = self:Get( 'Spectators', false )
    local Admins     = self:Get( 'Admins', false )

    Spectators:SetVisible( self.Config[ 'miscellaneous_spectator_list' ] )
    Admins:SetVisible( self.Config[ 'miscellaneous_admin_list' ] )
    
    -- Update bars.
    self.Bars:Update( Choke )

    -- Check lists.
    if ( not self.Config[ 'miscellaneous_spectator_list' ] and not self.Config[ 'miscellaneous_admin_list' ] ) then
        return
    end

    local Active = { }

    -- Clear indexes.
    Spectators:ClearIndexes( )
    Admins:ClearIndexes( )

    -- Update spectators.
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