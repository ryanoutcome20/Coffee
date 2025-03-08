function Coffee.Visuals:RenderChams( ENT, Assignment, Occluded, isOverlay )
    -- Get constants from menu.
    local Color = self.Config[ Assignment .. '_color' ]
    local Material = self.Config[ Assignment .. '_material' ]

    -- Check if we need to remove the orignal model.
    if ( not isOverlay and not Occluded and not self.Config[ Assignment .. '_original' ] ) then 
        ENT:SetRenderMode( RENDERMODE_NONE )
    end

    -- Set our IgnoreZ.
    cam.IgnoreZ( Occluded )

    -- Setup materials and colors.
    render.MaterialOverride( self.Materials:Get( Material, Occluded, Color ) )
    render.SetColorModulation( Color.r / 255, Color.g / 255, Color.b / 255 )
    render.SetBlend( Color.a / 255 )

    -- Render.
    ENT:DrawModel( )

    -- Restore rendering.
    cam.IgnoreZ( false )

    render.MaterialOverride( nil )
    render.SetColorModulation( 1, 1, 1 )
    render.SetBlend( 1 )

    -- Render overlay.
    if ( not isOverlay ) then
        local Overlay = Assignment .. '_overlay'

        if ( self.Config[ Overlay ] ) then 
            self:RenderChams( ENT, Overlay, Occluded, true )
        end
    end
end

function Coffee.Visuals:PlayerChams( )
    cam.IgnoreZ( true )

    for k, Target in pairs( self.Records.Entities ) do 
        if ( ( not Target:IsPlayer( ) or not Target:Alive( ) ) and not Target:IsRagdoll( ) ) then
            continue 
        end

        Target:SetRenderMode( RENDERMODE_NORMAL )

        local ENT = Target 

        if ( Target:IsRagdoll( ) ) then 
            ENT = Target:GetRagdollOwner( )
            
            if ( not ENT:IsPlayer( ) ) then 
                continue 
            end
        end

        self.CSEntity:Remove( Target:EntIndex( ) )

        local isLocal = ENT == self.Client.Local
        local isFriendly = ENT:Team( ) == self.Client.Team

        if ( isLocal ) then
            if ( self.Config[ 'esp_chams_local' ] ) then  
                self:RenderChams( Target, 'esp_chams_local' )
            end
        elseif ( isFriendly ) then 
            if ( self.Config[ 'esp_chams_friendly_visible' ] ) then 
                if ( self.Config[ 'esp_chams_friendly_invisible' ] ) then 
                    self:RenderChams( Target, 'esp_chams_friendly_invisible', true )
                end
    
                self:RenderChams( Target, 'esp_chams_friendly_visible', false )
            end

            if ( self.Config[ 'esp_chams_friendly_backtrack' ] ) then 
                self:BacktrackChams( Target, 'esp_chams_friendly_backtrack' )
            end
        else 
            if ( self.Config[ 'esp_chams_enemy_visible' ] ) then 
                if ( self.Config[ 'esp_chams_enemy_invisible' ] ) then 
                    self:RenderChams( Target, 'esp_chams_enemy_invisible', true )
                end
    
                self:RenderChams( Target, 'esp_chams_enemy_visible', false )
            end
            
            if ( self.Config[ 'esp_chams_enemy_backtrack' ] ) then 
                self:BacktrackChams( Target, 'esp_chams_enemy_backtrack' )
            end
        end
    end
end

function Coffee.Visuals:BacktrackChams( Target, Index )
    local Records = self.Records.Cache[ Target ]

    if ( not Records ) then 
        return
    end
    
    local Record = Records[ #Records ]

    if ( not Record ) then 
        return
    end

    local ENT = self.CSEntity:New( Target:EntIndex( ) )

    self.CSEntity:SetModel( ENT, Target:GetModel( ) )
    self.CSEntity:SetPosition( ENT, Record.Position )
    self.CSEntity:SetAngles( ENT, Record.Animations.Angles )

    self.CSEntity:AssignAnimations( ENT, Record.Animations )

    self:RenderChams( ENT, Index )
end

function Coffee.Visuals:FakeChams( )
    local ENT = self.CSEntity:New( 'Fake' )

    if ( not ENT ) then 
        return
    end

    if ( not self.Config[ 'esp_chams_local_fake' ] or not self.Config[ 'hvh_enabled' ] ) then 
        return self.CSEntity:Remove( 'Fake', ENT )
    end

    if ( not self.Config[ 'world_thirdperson' ] or not self.Menu:Keydown( 'world_thirdperson_keybind' ) ) then 
        return self.CSEntity:Remove( 'Fake', ENT )
    end

    local Record = table.Copy( self.Records:GetFront( self.Client.Local ) )

    if ( not Record ) then 
        return self.CSEntity:Remove( 'Fake', ENT )
    end

    if ( self.Ragebot.Fake ) then
        Record.Animations.Angles = self.Ragebot.Fake
    end

    self.CSEntity:SetModel( ENT, self.Client.Model )
    self.CSEntity:SetPosition( ENT, Record.Position )
    self.CSEntity:SetAngles( ENT, Record.Animations.Angles )

    self.CSEntity:AssignAnimations( ENT, Record.Animations )

    self:RenderChams( ENT, 'esp_chams_local_fake' )
end

function Coffee.Visuals:PostDrawViewModel( )
    if ( not self.Config[ 'esp_chams_viewmodel' ] ) then 
        return 
    end

    -- This way of rendering viewmodel chams need to be rewritten simply because
    -- they cause an unintentional render leakage into other hooks. Most evident
    -- is glow if you don't fix the materialoverride but adjusting blend can also
    -- effect rendering in other addons.

    -- Anything after PostDrawViewModel is effected.
    -- https://wiki.facepunch.com/gmod/Render_Order

    local Color, Material = nil, nil

    if ( self.Viewmodel ) then 
        Color = self.Config[ 'esp_chams_viewmodel_color' ]
        Material = self.Config[ 'esp_chams_viewmodel_material' ]
    elseif ( self.ViewmodelOverlay ) then 
        Color = self.Config[ 'esp_chams_viewmodel_overlay_color' ]
        Material = self.Config[ 'esp_chams_viewmodel_overlay_material' ]
    elseif ( not self.Config[ 'esp_chams_viewmodel_original' ] ) then 
        render.SetColorModulation( 1, 1, 1 )
        render.MaterialOverride( nil ) 
        render.SetBlend( 0 )   
    end

    if ( Color and Material ) then 
        render.MaterialOverride( self.Materials:Get( Material, false, Color ) )
        render.SetColorModulation( Color.r / 255, Color.g / 255, Color.b / 255 )
        render.SetBlend( Color.a / 255 )
    end
end

function Coffee.Visuals:PreDrawViewModel( Viewmodel, Local )
    if ( self.Config[ 'esp_chams_viewmodel' ] ) then 
        render.SetColorModulation( 1, 1, 1 )
        render.MaterialOverride( nil ) 
        render.SetBlend( 1 )
        
        if ( not self.Viewmodel ) then             
            self.Viewmodel = true 
                Viewmodel:DrawModel( )
            self.Viewmodel = false 
        end
    
        if ( not self.ViewmodelOverlay and self.Config[ 'esp_chams_viewmodel_overlay' ] ) then 
            self.ViewmodelOverlay = true 
                Viewmodel:DrawModel( )
            self.ViewmodelOverlay = false 
        end

        if ( self.Config[ 'esp_chams_viewmodel_original' ] ) then 
            Local:GetHands( ):DrawModel( )
        end
    end
end

Coffee.Hooks:New( 'PostDrawViewModel', Coffee.Visuals.PostDrawViewModel, Coffee.Visuals )
Coffee.Hooks:New( 'PreDrawViewModel', Coffee.Visuals.PreDrawViewModel, Coffee.Visuals )