Coffee.Require = { 
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