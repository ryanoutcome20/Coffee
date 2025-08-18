--[[
	Simple fix for the proxi module.
]]--

Coffee.Packets = {
	Require = Coffee.Require
}

function Coffee.Packets:Handle( )
	local Status = self.Require.Choked
	
	return Status, Status
end

Coffee.Hooks:New( 'CreateMoveEx', Coffee.Packets.Handle, Coffee.Packets )