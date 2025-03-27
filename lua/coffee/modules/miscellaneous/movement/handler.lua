function Coffee.Miscellaneous:Bunnyhop( CUserCMD )
    if ( not self.Config[ 'miscellaneous_bunnyhop' ] ) then 
        return
    end

    if ( self.Client.Local:IsFlagSet( FL_ONGROUND ) ) then 
        return
    end

    if ( CUserCMD:KeyDown( IN_JUMP ) ) then 
        CUserCMD:RemoveKey( IN_JUMP )
    end
end

function Coffee.Miscellaneous:Autostrafe( CUserCMD )
    if ( not self.Config[ 'miscellaneous_autostrafe' ] ) then 
        return
    end

    if ( not CUserCMD:KeyDown( IN_JUMP ) ) then 
        return
    end

    -- Calculate our switch.
    -- May become problematic if we end up breaking command number via desynculator
    -- or other similar exploits.
    local Switch = CUserCMD:CommandNumber( ) % 2 == 0
    
    -- Check if we're using classic style.
    if ( self.Config[ 'miscellaneous_autostrafe_style' ] == 'Classic' ) then 
        -- This is what most cheats use and honestly I have no idea where they came to the conclusion with
        -- some of these numbers.

        -- Prevent us from countering the movement direction of the mouse.
        if ( not self.Config[ 'miscellaneous_autostrafe_unlock' ] and self.Client.Local:IsFlagSet( FL_ONGROUND ) ) then
            CUserCMD:SetForwardMove( 10000 )
            return
        end

        -- No idea.
        CUserCMD:SetForwardMove( 5850 / self.Client.Speed )

        -- Adjust our sidemove based on switch.
        local Adjustment = self.Config[ 'miscellaneous_autostrafe_clamp' ] and 2500 or 400

        if ( Switch ) then 
            CUserCMD:SetSideMove( Adjustment )
        else
            CUserCMD:SetSideMove( -Adjustment )
        end
    else
        -- This is just a basic strafer for people to use if they want to look more legit.
        if ( Switch ) then 
            CUserCMD:SetSideMove( 2500 )
        else
            CUserCMD:SetSideMove( -2500 )
        end
    end
end

function Coffee.Miscellaneous:QuickMovement( CUserCMD )
    if ( not self.Config[ 'miscellaneous_quick_acceleration' ] ) then 
        return
    end

    if ( not self.Client.Local:IsFlagSet( FL_ONGROUND ) ) then 
        return
    end

    local Forward = CUserCMD:GetForwardMove( )
    
    if ( Forward > 0 ) then 
        CUserCMD:SetForwardMove( 10000 )
    elseif ( Forward < 0 ) then
        CUserCMD:SetForwardMove( -10000 )
    end

    local Side = CUserCMD:GetSideMove( )
    
    if ( Side > 0 ) then 
        CUserCMD:SetSideMove( 10000 )
    elseif ( Side < 0 ) then
        CUserCMD:SetSideMove( -10000 )
    end


    if ( self.Config[ 'miscellaneous_quick_acceleration_sprint' ] ) then 
        CUserCMD:AddKey( IN_SPEED )
    end
end