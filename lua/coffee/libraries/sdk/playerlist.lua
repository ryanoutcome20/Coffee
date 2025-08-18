Coffee.Playerlist = {
	Require = Coffee.Require,
	
    Cache = { }
}

function Coffee.Playerlist:Grab( ENT, What )
	if ( not ENT or not What ) then
		return false
	end

	self.Cache[ ENT ] = self.Cache[ ENT ] or {
		Whitelist = false,
		Highlight = false,
		Chat = false
	}

	return self.Cache[ ENT ][ What ]
end

function Coffee.Playerlist:Node( ENT, Tree )
	local Node = Tree:AddNode( ENT:Name(), 'icon16/user_green.png' )
	
	self.Cache[ ENT ] = self.Cache[ ENT ] or {
		Whitelist = false,
		Highlight = false,
		Chat = false
	}
	
	if ( not self.Cache[ ENT ].Whitelist and ENT ~= Coffee.Client.Local ) then
		Node:SetIcon( 'icon16/user_red.png' )
	end
	
    Node.DoClick = function( Node )
		if ( ENT == Coffee.Client.Local ) then
			return
		end

		local Menu = DermaMenu( )
        local Cache = Coffee.Playerlist.Cache[ ENT ]
		
		if ( Cache.Whitelist ) then
			Menu:AddOption( 'Remove Whitelist', function( ) 
                Cache.Whitelist = false
				
				Node:SetIcon( 'icon16/user_red.png' )
            end ):SetIcon( 'icon16/heart_delete.png' )
		else
            Menu:AddOption( 'Add Whitelist', function( ) 
                Cache.Whitelist = true
				
				Node:SetIcon( 'icon16/user_green.png' )
            end ):SetIcon( 'icon16/heart_add.png' )
		end
		
		if ( Cache.Highlight ) then
			Menu:AddOption( 'Remove Highlight', function( ) 
                Cache.Highlight = false
            end ):SetIcon( 'icon16/bullet_red.png' )
		else
            Menu:AddOption( 'Add Highlight', function( ) 
                Cache.Highlight = true
            end ):SetIcon( 'icon16/bullet_green.png' )
		end
		
		if ( Cache.Chat ) then
			Menu:AddOption( 'Unblock Chat', function( ) 
                Cache.Chat = false
            end ):SetIcon( 'icon16/add.png' )
		else
            Menu:AddOption( 'Block Chat', function( ) 
                Cache.Chat = true
            end ):SetIcon( 'icon16/cancel.png' )
		end
		
        Menu:AddOption( 'Steal Name', function( ) 
            self.Require:SetConVar( 'Name', '\xe2\x80\x8b' .. ENT:Name( ) )
        end ):SetIcon( 'icon16/arrow_in.png' )

        Menu:AddOption( 'Steal Name (RP)', function( ) 
			RunConsoleCommand("say", "/rpname " .. ENT:Name( ) )
        end ):SetIcon( 'icon16/arrow_out.png' )

        Menu:AddOption( 'Copy SteamID', function( ) 
            SetClipboardText( ENT:SteamID( ) )
        end ):SetIcon( 'icon16/paste_plain.png' )

        Menu:AddOption( 'Copy SteamID64', function( ) 
            SetClipboardText( ENT:SteamID64( ) )
        end ):SetIcon( 'icon16/paste_word.png' )

        Menu:AddOption( 'Open Steam', function( ) 
            gui.OpenURL(
				string.format(
					"https://steamcommunity.com/profiles/%s/",
					ENT:SteamID64( )
				)
			)
        end ):SetIcon( 'games/16/all.png' )

		Menu.Paint = function( self, W, H )
			surface.SetDrawColor( 20, 20, 20, 255 )
			surface.DrawRect( 0, 0, W, H )
				
		    surface.SetDrawColor( Coffee.Menu.Color )
			surface.DrawOutlinedRect( 0, 0, W, H, 1 )

			for i = 1, self:ChildCount( ) do
				local Selection = self:GetChild( i )

				if ( Coffee.Config[ 'miscellaneous_menu_labels' ] ) then 
					Selection:SetTextColor( Coffee.Menu.Color )
				else
					Selection:SetTextColor( Coffee.Colors[ 'White' ] )
				end
			end
		end

        Menu:Open( )
	end
	
	Node.DoRightClick = function( self ) end

	return Node
end

function Coffee.Playerlist:Refresh( )
	local Tree = self.DTree

	if ( not Tree ) then 
		return
	end
	
	local Root = Tree:Root( )
	
	Root.Items = Root.Items or { }
	
	for i = 0, Root:GetChildNodeCount( ) - 1 do
		local Node = Root:GetChildNode( i )
		
		if ( not Node ) then
			break
		end
		
		Node:Remove( )
	end
	
	Root:CleanList( )

	for k, ENT in pairs( player.GetAll( ) ) do 
		self:Node( ENT, Tree )
	end
end