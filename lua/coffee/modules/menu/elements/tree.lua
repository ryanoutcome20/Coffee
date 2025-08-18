function Coffee.Menu:GenerateTree( Panel, Name )
    -- Have to generate the tree panel used by the player list.

	local DTree = vgui.Create( 'DTree', Panel )
	DTree:Dock( FILL )

    DTree.Paint = function( self, W, H )
        surface.SetDrawColor( 20, 20, 20, 120 )
        surface.DrawRect( 0, 0, W, H )

		local Root = DTree:Root( )
		
		for i = 0, Root:GetChildNodeCount( ) - 1 do
			local Node = Root:GetChildNode( i )
			
			if ( not Node ) then
				break
			end
			
			if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
				Node.Label:SetTextColor( Coffee.Menu.Color )
			else
				Node.Label:SetTextColor( Coffee.Colors[ 'White' ] )
			end
			
			Node.Label:SetHighlight( false )
			Node.Label.Paint = function( self, W, H )
				if ( self.m_bSelected ) then
					local tW, tH = self:GetTextSize( )
				
					surface.SetDrawColor( 
						Coffee.Menu.Color.r, 
						Coffee.Menu.Color.g, 
						Coffee.Menu.Color.b, 
						15
					)
					
					surface.DrawRect( 38, 0, tW + 6, tH + 6 )
				end
			end
		end
    end
	
    local Bar = DTree:GetVBar( )
    Bar:SetWide( self:Scale( 6 ) )
    Bar:SetHideButtons( true )

    Bar.Paint = function( self, W, H )
        surface.SetDrawColor( 18, 18, 18 )
        surface.DrawRect( 0, 0, W, H )
    end

    Bar.btnGrip.Paint = function( self, W, H )
        surface.SetDrawColor( Coffee.Menu.Color )
        surface.DrawRect( 0, 0, W, H )
    end

	DTree.OnNodeSelected = function( Node ) end
	
	self.Playerlist.DTree = DTree
	
	return DTree
end