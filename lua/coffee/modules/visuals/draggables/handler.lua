Coffee.Draggables = {
    Records    = Coffee.Records,
    Client     = Coffee.Client,
    Config     = Coffee.Config,
    Menu       = Coffee.Menu,
	Playerlist = Coffee.Playerlist,

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

function Coffee.Draggables:UpdateWrapper( Callback, Into, From )
	From = From or self.Records.Players

	local Active = { }
	
	for k,v in pairs( From ) do 
		if ( not IsValid( v ) ) then
			continue
		end
	
		local Text = Callback( v )
	
        if ( Text ) then
			table.insert( Active, Text )
		end
    end

    table.sort( Active )

    Into:AddIndexes( Active )
end

function Coffee.Draggables:Update( )
    if (not IsValid(self.Client.Local)) then
        return
    end

    -- Get panels.
    local Spectators  = self:Get( 'Spectators', false )
    local Admins      = self:Get( 'Admins', false )
    local Highlighted = self:Get( 'Highlighted Players', false )

    Spectators:SetVisible( Coffee.Config[ 'miscellaneous_spectator_list' ] )
    Admins:SetVisible( Coffee.Config[ 'miscellaneous_admin_list' ] )
    Highlighted:SetVisible( Coffee.Config[ 'miscellaneous_highlight_list' ] )

    -- Update bars.
    self.Bars:Update( Choke )

    -- Check lists.
    if ( not Coffee.Config[ 'miscellaneous_spectator_list' ] and not Coffee.Config[ 'miscellaneous_admin_list' ] and not Coffee.Config[ 'miscellaneous_highlight_list' ] ) then
        return
    end

    local Active = { }

    -- Clear indexes.
    Spectators:ClearIndexes( )
    Admins:ClearIndexes( )
    Highlighted:ClearIndexes( )
	
    -- Update spectators.
	self:UpdateWrapper( function( Target )
        if ( Target:GetObserverTarget( ) == self.Client.Local ) then 
            local Mode = self.Observers[ Target:GetObserverMode( ) ] or 'Other'
            
            return string.format( '%s (%s)', Target:Name( ), Mode )
        end
    end, Spectators )

    -- Update admins. 
	self:UpdateWrapper( function( Target )
        if ( Target:IsAdmin( ) or Target:IsSuperAdmin( ) ) then 
            local Distance = 'Dormant'

            if ( not Target:IsDormant( ) ) then 
                Distance = math.Round( self.Client.Position:Distance2D( Target:GetPos( ) ) ) .. 'hu'
            end
			
			local Alive = ''
			
			if ( Coffee.Config[ 'miscellaneous_admin_list_alive' ] ) then
				Alive = ' [' .. ( Target:Alive() and 'alive' or 'dead' ) .. ']'
			end
			
			return string.format( '%s%s (%s)', Target:Name( ), Alive, Distance )
        end
    end, Admins )

    -- Update highlighted. 
	self:UpdateWrapper( function( Target )
        if ( self.Playerlist:Grab( Target, "Highlight" ) ) then 
            local Distance = 'Dormant'

            if ( not Target:IsDormant( ) ) then 
                Distance = math.Round( self.Client.Position:Distance2D( Target:GetPos( ) ) ) .. 'hu'
            end

            return string.format( '%s (%s)', Target:Name( ), Distance )
        end
    end, Highlighted )
end

Coffee.Hooks:New( 'Tick', Coffee.Draggables.Update, Coffee.Draggables )