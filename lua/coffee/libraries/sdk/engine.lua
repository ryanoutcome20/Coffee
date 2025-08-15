local cl_interpolate             = GetConVar( 'cl_interpolate' )
local cl_interp_ratio            = GetConVar( 'cl_interp_ratio' )
local cl_interp                  = GetConVar( 'cl_interp' )
local cl_updaterate              = GetConVar( 'cl_updaterate' )
local sv_minupdaterate           = GetConVar( 'sv_minupdaterate' )
local sv_maxupdaterate           = GetConVar( 'sv_maxupdaterate' )
local sv_client_min_interp_ratio = GetConVar( 'sv_client_min_interp_ratio' )
local sv_client_max_interp_ratio = GetConVar( 'sv_client_max_interp_ratio' )

function TIME_TO_TICKS( Time )
    return math.floor( 0.5 + Time / engine.TickInterval( ) )
end

function TICKS_TO_TIME( Tick )
    return engine.TickInterval( ) * Tick
end

function GetLerpTime()
    -- https://github.com/ValveSoftware/source-sdk-2013/blob/e42867ad64f77845d8c2383204ff446cd378f037/src/game/server/player.cpp#L3484

    if ( cl_interpolate and not cl_interpolate:GetBool( ) ) then 
        return 0
    end

    -- Get our update rate.
    local Rate = cl_updaterate:GetInt( )

    if ( sv_minupdaterate and sv_maxupdaterate ) then 
        Rate = math.Clamp( Rate, sv_minupdaterate:GetInt( ), sv_maxupdaterate:GetInt( ) )
    end

    -- Get our ratio and amount.
    local Ratio  = cl_interp_ratio:GetFloat( )
    local Amount = cl_interp:GetFloat( )

    if ( Ratio == 0 ) then 
        Ratio = 1
    end

    -- Clamp our ratio.
    local Min = sv_client_min_interp_ratio:GetFloat( )
    local Max = sv_client_max_interp_ratio:GetFloat( )

    if ( Min and Max and Min != -1 ) then 
        Ratio = math.Clamp( Ratio, Min, Max )
    end

    -- Return finished value.
    return math.max( Amount, Ratio / Rate )
end

local Movement = {
	0,
	
	2500,
	5000,
	7500,
	10000,
	
	-2500,
	-5000,
	-7500,
	-10000,
}

function ClampMovement(In)
	local Closest = Movement[ 1 ]
    local Best = math.abs( In - Closest )
    
    for i = 2, #Movement do
        local Value = math.abs( In - Movement[ i ] )

        if Value < Best then
            Closest = Movement[ i ]
            Best = Value
        end
    end
    
    return Closest
end