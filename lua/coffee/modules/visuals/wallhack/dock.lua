function Coffee.Visuals:HandleIntrinsicDock( Dock, Offset, X, Y )
    if ( Dock == 'Right' ) then 
        X = self.Position.X + self.Position.W / 2 + Offset
        Y = self.Position.Y - self.Position.H
    elseif ( Dock == 'Left' ) then 
        X = self.Position.X - self.Position.W / 2 - Offset
        Y = self.Position.Y - self.Position.H
    end

    return X, Y
end

function Coffee.Visuals:GetIntrinsicDock( Dock )
    return Dock == 'Left' and 'Left Intrinsic' or 'Right Intrinsic'
end

function Coffee.Visuals:HandleDock( Dock, Text, intrinsicOffset )
    -- Get our local variables.
    local X, Y = 0, 0

    -- Get intrinsic dock.
    local Intrinsic = self:GetIntrinsicDock( Dock )

    -- Get intrinsic offset.
    local Localized = self.Offsets[ Intrinsic ]

    -- Get global offset.
    local Offset = self.Offsets[ Dock ]

    -- Call upon intrinsic offset calculations for bars.
    if ( intrinsicOffset ) then 
        X, Y = self:HandleIntrinsicDock( Dock, Localized, X, Y )

        self.Offsets[ Intrinsic ] = Localized + intrinsicOffset

        return X, Y
    end

    -- Get text size.
    local W, H = surface.GetTextSize( Text )

    if ( Dock == 'Top' ) then 
        X = self.Position.X - W / 2
        Y = self.Position.Y - self.Position.H - Offset
    elseif ( Dock == 'Bottom' ) then 
        X = self.Position.X - W / 2
        Y = self.Position.Y + Offset
    elseif ( Dock == 'Right' ) then 
        X = self.Position.X + self.Position.W / 2 + Localized
        Y = self.Position.Y - self.Position.H + Offset
    elseif ( Dock == 'Left' ) then 
        X = self.Position.X - self.Position.W / 2 - W - Localized
        Y = self.Position.Y - self.Position.H + Offset        
    end

    self.Offsets[ Dock ] = Offset + H

    return X, Y
end