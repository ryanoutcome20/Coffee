function Coffee.Visuals:RenderChams( ENT, Assignment, Occluded, isOverlay )
    -- Get constants from menu.
    local Color = self.Config[ Assignment .. '_color' ]
    local Material = self.Config[ Assignment .. '_material' ]

    -- Check if we need to remove the orignal model.
    if ( not isOverlay and not Occluded and not self.Config[ Assignment .. '_original' ] ) then 
        ENT:SetRenderMode( RENDERMODE_NONE )
    end

    -- Setup rendering.
    cam.IgnoreZ( Occluded )

    render.MaterialOverride( self.Materials:Get( Material, Occluded ) )
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
        else 
            if ( self.Config[ 'esp_chams_enemy_visible' ] ) then 
                if ( self.Config[ 'esp_chams_enemy_invisible' ] ) then 
                    self:RenderChams( Target, 'esp_chams_enemy_invisible', true )
                end
    
                self:RenderChams( Target, 'esp_chams_enemy_visible', false )
            end
        end
    end
end

function Coffee.Visuals:PostDrawViewModel( )
    if ( not self.Config[ 'esp_chams_viewmodel' ] ) then 
        return 
    end

    local Color, Material = nil, nil

    if ( self.Viewmodel ) then 
        Color = self.Config[ 'esp_chams_viewmodel_color' ]
        Material = self.Config[ 'esp_chams_viewmodel_material' ]
    elseif ( self.ViewmodelOverlay ) then 
        Color = self.Config[ 'esp_chams_viewmodel_overlay_color' ]
        Material = self.Config[ 'esp_chams_viewmodel_overlay_material' ]
    elseif ( not self.Config[ 'esp_chams_viewmodel_original' ] ) then 
        render.SetBlend( 0 )
    end

    if ( Color and Material ) then 
        render.MaterialOverride( self.Materials:Get( Material, false ) )
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