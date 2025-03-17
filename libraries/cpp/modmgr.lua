Coffee.Require = { 
    Config = Coffee.Config,

    Active = '',
    Data = {
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
                if ( not self.Config[ 'aimbot_engine' ] ) then 
                    return
                end
                
                return ded.StartPrediction( CUserCMD )
            end,

            [ 'EndPrediction' ] = function( self, CUserCMD )
                if ( not self.Config[ 'aimbot_engine' ] ) then 
                    return
                end
                
                return ded.FinishPrediction( CUserCMD )
            end,

            [ 'SetContextVector' ] = function( self, CUserCMD, Angle )
                return ded.SetContextVector( CUserCMD, Angle:Forward( ), true )
            end,

            [ 'SetConVar' ] = function( self, ConVar, Value )
                return ded.NetSetConVar( ConVar, Value )
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
end

function Coffee.Require:Init( )
    for Index, Data in pairs( self.Data ) do
        if ( util.IsBinaryModuleInstalled( Index ) ) then 
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