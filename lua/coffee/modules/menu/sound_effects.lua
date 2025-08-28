Coffee.Menu.SFX = { 
	IDs = {
		[ 'Button' ] =  'miscellaneous_sfx_buttons',
		[ 'Startup' ] = 'miscellaneous_sfx_startup',
		[ 'Shutdown' ] = 'miscellaneous_sfx_shutdown'
	}
}

function Coffee.Menu.SFX:Play( ID )
	if ( not ID or not Coffee.Config[ 'miscellaneous_sfx' ] ) then
		return
	end
	
	surface.PlaySound( Coffee.Config[ self.IDs[ ID ] ] )
end

timer.Simple( 0, function( )
	Coffee.Menu.SFX:Play( 'Startup' )
end )

Coffee.Hooks:New( 'ShutDown', function( )
	Coffee.Menu.SFX:Play( 'Shutdown' )
end )