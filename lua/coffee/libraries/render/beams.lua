Coffee.Beams = { }

function Coffee.Beams:Render( Start, End, Speed, Amplitude, Twist, Cone, Segments, Width, firstColor, secondColor, Material )
    -- This turned out to be too complicated to have in the overlay renderer.

    -- Get the central axis direction.
    local Forward = Start - End

    Forward:Normalize( )

    -- Calculate our rotation vectors.
    local Right = Vector( Forward.y, -Forward.x, 0 )

    Right:Normalize( )

    local Up = Forward:Cross( Right )

    Up:Normalize( )

    -- Get our time.
    local Time = CurTime( )

    -- Get our texture offset.
    Speed = Speed * Time

    -- Setup cached variables for use in the loop.
    local Main, Secondary = Start, Start

    -- Main loop.
    for i = 1, Segments do
        local Position = LerpVector( i / Segments, Start, End )

        -- Get twist angle.
        local Angle = i * Twist

        -- Get noise amplitude.
        local Noise = Vector( math.sin( Time * 2 + i ) * Amplitude, 0, 0 )

        -- Get our offsets.
        local mainOffset      = Right * math.cos( Angle ) * Cone + Up * math.sin( Angle ) * Cone
        local secondaryOffset = Right * math.cos( Angle + math.pi ) * Cone + Up * math.sin( Angle + math.pi) * Cone

        -- Apply amplitude noise, adjusts the length of the waves.
        mainOffset      = mainOffset + Noise
        secondaryOffset = secondaryOffset + Noise

        -- Get our final positions.
        local mainPosition      = Position + mainOffset
        local secondaryPosition = Position + secondaryOffset

        -- Get texture scrolling.
        local textureStart = Speed + ( i / Segments ) * 2
        local textureEnd   = Speed + ( ( i + 1 ) / Segments ) * 2

        -- Render!
        render.SetMaterial( Material )
        render.DrawBeam( Main, mainPosition, Width, textureStart, textureEnd, firstColor )

        render.SetMaterial( Material )
        render.DrawBeam( Secondary, secondaryPosition, Width, textureStart, textureEnd, secondColor )

        -- Update our cached positions for next time.
        Main      = mainPosition
        Secondary = secondaryPosition
    end
end