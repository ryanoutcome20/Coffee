function Coffee.Miscellaneous:Chat( Target, Text, Chat )
	if ( self.Playerlist:Grab( Target, "Chat" ) ) then
		return ""
	end
	
	if ( Coffee.Config[ 'miscellaneous_filter' ] ) then
		local Bad = {
			"\n",
			"\b",
			"\t"
		}
		
		for k, Blocked in ipairs( Bad ) do
			Text = string.Replace( Blocked, "" )
		end
		
		return Text
	end
end

Coffee.Hooks:New( 'PlayerSay', Coffee.Miscellaneous.Chat, Coffee.Miscellaneous )