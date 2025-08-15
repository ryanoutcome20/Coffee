function Coffee.Miscellaneous:Load( )
	-- This is kinda hacked in, ignore the messy recursive code.

	local Name = Coffee.Config[ 'miscellaneous_config' ] .. '.txt'
	
	local Data = file.Read( Name )
	
	if ( not Data ) then
		return
	end
	
	Data = util.JSONToTable( Data )
	
	if ( not istable( Data ) ) then
		return
	end
	
	for Index, Object in pairs( Data ) do 
		if ( istable( Object ) and Object.r and Object.g and Object.b ) then
			Data[ Index ] = Color( Object.r, Object.g, Object.b, Object.a or 255 )
		end
		
		Coffee.Config[ Index ] = Data[ Index ]
	end

	local function Wrapper( Panel )
		if ( not IsValid( Panel ) ) then
			return
		end
	
		local Children = Panel:GetChildren( )
		
		if ( Panel.OnConfigLoad ) then
			Panel:OnConfigLoad( )
		end
		
		for k, Object in pairs( Children ) do 
			Wrapper( Object )
		end
	end
	
	for k, Tab in pairs( Coffee.Menu.Tabs ) do
		Wrapper( Tab.LeftS )
		Wrapper( Tab.RightS )
	end
end

function Coffee.Miscellaneous:Save( )
	local Name = Coffee.Config[ 'miscellaneous_config' ] .. '.txt'
	
	file.Write(
		Name,
		util.TableToJSON(
			Coffee.Config
		)
	)
end