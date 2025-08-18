Coffee.Items = { 
    Cache = { }
}

function Coffee.Items:Refresh( )
    local New = { }

    for k, Target in ipairs( ents.GetAll( ) ) do 
        if ( not Target or not IsValid( Target ) ) then 
            continue
        end

        if ( Target:IsPlayer( ) or Target:IsNPC( ) or Target:IsNextBot( ) ) then 
            continue
        end

        local Class = string.lower( Target:GetClass( ) )

        if ( self.Cache[ Class ] != nil ) then 
            continue
        end

        self.Cache[ Class ] = false
        New[ Class ] = false
    end

    return New, self.Cache
end

function Coffee.Items:Valid( Name )
    return self.Cache[ Name ]
end

function Coffee.Items:Get( )
    local Targets, Found = ents.GetAll( ), { }

    for k, Target in ipairs( Targets ) do 
        if ( not Target or not IsValid( Target ) ) then 
            continue
        end

        if ( Target:IsPlayer( ) or Target:IsNPC( ) or Target:IsNextBot( ) ) then 
            continue
        end
    
        local Class = string.lower( Target:GetClass( ) )

        if ( self.Cache[ Class ] ) then 
            table.insert( Found, { 
                Target = Target, 
                Class  = Class
            } )
        end
    end

    return Found
end

function Coffee.Items:Update( Panel )
    -- This is specifically for the item list panel. Would move it to
    -- that file but the file structure of the menu panels is pretty
    -- static.

    if ( not Panel or not Panel.Add ) then
        return
    end

    local New = self:Refresh( )

    for k,v in pairs( New ) do 
        local Button = Panel:Add( k )

		Button.Paint = function( self, W, H )
			if ( Coffee.Items:Valid( k ) ) then 
				self:SetTextColor( Coffee.Menu.Color )
			elseif ( self.Depressed or self.m_bSelected ) then 
				self:SetTextColor( Coffee.Colors[ 'White' ] )
			else 
				self:SetTextColor( Coffee.Colors[ 'Light Gray' ] )
			end
		end
    end
end

function Coffee.Items:Select( Checked, Panel, affectAll )
    if ( not Panel ) then 
        return
    end

    local Children = Panel:GetChildren( )

    for k, Panel in ipairs( Children ) do 
        if ( affectAll or Panel.m_bSelected ) then 
            self.Cache[ Panel:GetText( ) ] = Checked
        end
    end
end