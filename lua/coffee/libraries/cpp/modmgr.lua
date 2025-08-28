Coffee.Require = { 
    Active = '',
	Choked = false,
    Data = {
		[ 'proxi' ] = {
            [ 'PreFrameStageNotify' ] = function( self )
                return 'PreFrameStageNotify'
            end,

            [ 'FrameStageNotify' ] = function( self )
                return 'PostFrameStageNotify'
            end,

            [ 'Simulation' ] = function( self, ENT )
                return ENT:GetDTNetVar( 'DT_BaseEntity->m_flSimulationTime', 1 )
            end,

            [ 'Servertime' ] = function( self, CUserCMD )
                return TICKS_TO_TIME( LocalPlayer( ):GetInternalVariable( 'm_nTickBase' ) )
            end,

            [ 'Latency' ] = function( self, Mode )
                if ( Mode == 0 ) then
					return proxi.GetFlowOutgoing( )
				elseif ( Mode == 1 ) then
					return proxi.GetFlowIncoming( )
				end
				
				return LocalPlayer( ):Ping( )
            end,

            [ 'StartPrediction' ] = function( self, CUserCMD )                
                return proxi.StartPrediction( CUserCMD )
            end,

            [ 'EndPrediction' ] = function( self, CUserCMD )                
                return proxi.EndPrediction( CUserCMD )
            end,

            [ 'SetContextVector' ] = function( self, CUserCMD, Angle )
				CUserCMD:SetInWorldClicker( true )
				
                return CUserCMD:SetWorldClickerAngles( Angle:Forward( ) )
            end,

            [ 'SetConVar' ] = function( self, ConVar, Value )
                local Object = proxi.GetConVar( ConVar )
				
				Object:SendValue( Value )
				
				return Object
            end,

            [ 'SetConVarFlags' ] = function( self, ConVar, Flags )
                local Object = proxi.GetConVar( ConVar )
				
				Object:SetFlags( Flags )
				
				return Object
			end,

            [ 'ForceConVar' ] = function( self, ConVar, Value )
			    local Object = GetConVar( ConVar )

                if ( isstring( Value ) ) then
					Object:ForceString( Value )
				elseif ( isnumber( Value ) ) then
					Object:ForceFloat( Value )
				elseif ( isbool( Value ) ) then
					Object:ForceBool( Value )
				end
				
				return Object
            end,

            [ 'SetInterpolation' ] = function( self, Time )
				-- SetDTNetVar?
            end,

            [ 'SetTickCount' ] = function( self, CUserCMD, Tick )
                return CUserCMD:SetTickCount( Tick )
            end,

            [ 'SetOutSequence' ] = function( self, Seq )
                return proxi.SetSequenceNumber( Seq )
            end,

            [ 'GetOutSequence' ] = function( self )
                return proxi.GetSequenceNumber( )
            end,

            [ 'Slowmotion' ] = function( self, Value )
                -- ...?
            end,

            [ 'BSendPacket' ] = function( self, Value )
                Coffee.Require.Choked = Value
				return Value
            end,
				
			[ 'SetDisconnectReason' ] = function( self, Reason )
				return proxi.Disconnect( Reason )
			end,
            
			[ 'SetRandomSeed' ] = function( self, CUserCMD, Seed )
				return CUserCMD:SetRandomSeed( Seed )
			end,
			
            [ 'GetRandomSeed' ] = function( self, CUserCMD )
                return CUserCMD:GetRandomSeed( )
            end
        },
	
        [ 'zxcmodule' ] = {
            [ 'PreFrameStageNotify' ] = function( self )
                return 'PreFrameStageNotify'
            end,

            [ 'FrameStageNotify' ] = function( self )
                return 'PostFrameStageNotify'
            end,

            [ 'Simulation' ] = function( self, ENT )
                return ded.GetSimulationTime( ENT:EntIndex( ) )
            end,

            [ 'Servertime' ] = function( self, CUserCMD )
                return ded.GetServerTime( CUserCMD )
            end,

            [ 'Latency' ] = function( self, Mode )
                return ded.GetLatency( Mode )
            end,

            [ 'StartPrediction' ] = function( self, CUserCMD )                
                return ded.StartPrediction( CUserCMD )
            end,

            [ 'EndPrediction' ] = function( self, CUserCMD )                
                return ded.FinishPrediction( CUserCMD )
            end,

            [ 'SetContextVector' ] = function( self, CUserCMD, Angle )
                return ded.SetContextVector( CUserCMD, Angle:Forward( ), true )
            end,

            [ 'SetConVar' ] = function( self, ConVar, Value )
                return ded.NetSetConVar( ConVar, Value )
            end,

            [ 'SetConVarFlags' ] = function( self, ConVar, Flags )
                return ded.ConVarSetFlags( ConVar, Flags )
            end,

            [ 'ForceConVar' ] = function( self, ConVar, Value )
                return ded.ConVarSetValue( ConVar, Value )
            end,

            [ 'SetInterpolation' ] = function( self, Time )
                return ded.SetInterpolationAmount( Time )
            end,

            [ 'SetTickCount' ] = function( self, CUserCMD, Tick )
                return ded.SetCommandTick( CUserCMD, Tick )
            end,

            [ 'SetOutSequence' ] = function( self, Seq )
                return ded.SetOutSequenceNr( Seq )
            end,

            [ 'GetOutSequence' ] = function( self )
                return ded.GetOutSequenceNr( )
            end,

            [ 'Slowmotion' ] = function( self, Value )
                return ded.EnableSlowmotion( Value )
            end,

            [ 'BSendPacket' ] = function( self, Value )
                return ded.SetBSendPacket( Value )
            end,
			
			[ 'SetDisconnectReason' ] = function( self, Reason )
				return ded.NetDisconnect( Reason )
			end,
			
			[ 'SetRandomSeed' ] = function( self, CUserCMD, Seed )
				-- ...
			end,
            
            [ 'GetRandomSeed' ] = function( self, CUserCMD )
                return ded.GetRandomSeed( CUserCMD )
            end
        },
    }
}

function Coffee.Require:PostInit( Index, Data )
    self.Active = Index

    for k,v in pairs( Data ) do 
        self[ k ] = v
    end
	
	if ( __G[ Index ] ) then
		_G[ Index ] = __G[ Index ]
	end
end

function Coffee.Require:Init( )
    for Index, Data in pairs( self.Data ) do
        if ( file.Exists( "lua/bin/gmcl_" .. Index .. "_win64.dll", "MOD" ) ) then 
            require( Index )
            Coffee:Print( false, 'Loaded binary module %s!', Index )
            self:PostInit( Index, Data )
            return true
        end
    end
    
    Coffee:Print( true, 'A binary module is required for the cheat to function properly!' )
    
    return false
end

return Coffee.Require:Init( )