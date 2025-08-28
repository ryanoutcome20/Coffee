local Meta = FindMetaTable("Player")

local GetUserGroup = Meta.GetUserGroup

Meta.GetUserGroup = function(self)
	if Coffee.Config["miscellaneous_spoof_usergroup"] and self == Coffee.Client.Local then
		return Coffee.Config["miscellaneous_spoof_usergroup_group"]
	end
	
	return GetUserGroup(self)
end