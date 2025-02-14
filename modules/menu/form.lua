Coffee.Menu:Handle( 'Players', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    
    self:GenerateCheckbox( Panel, 'Visualize Dormancy', 'esp_dormant' )
    
    self:GenerateCheckbox( Panel, 'Box', 'esp_box' )
    self:GenerateColorpicker( nil, 'esp_box_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_box_color_outline', self.Colors.Black )
    self:GenerateDropdown( nil, 1, 'esp_box_type', {
        '2D',
        '3D'
    } )
    
    self:GenerateCheckbox( Panel, 'Name', 'esp_name' )
    self:GenerateColorpicker( nil, 'esp_name_color', self.Colors.White )
    self:GenerateDropdown( nil, 3, 'esp_name_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Weapon', 'esp_weapon'  )
    self:GenerateColorpicker( nil, 'esp_weapon_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_weapon_type', {
        'Text',
        'Icons'
    } )
    self:GenerateDropdown( nil, 4, 'esp_weapon_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Healthbar', 'esp_healthbar'  )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Override Healthbar Color', 'esp_healthbar_override'  )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_down', self.Colors.Main )
    
    self:GenerateCheckbox( Panel, 'Override Healthbar Lines', 'esp_healthbar_lines'  )
    self:GenerateSlider( nil, 'esp_healthbar_lines_amount', 1, 8, 4, 0 )

    -- self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    -- self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    -- self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    -- self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    -- self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )

end )

Coffee.Menu:Handle( 'Players', function( self, Panel )
    
end, true )

--[[
    Enabled
    Dormant Fade
    Box
    Name
    Weapon (text/icon)
    Healthbar
    Override Healthbar Color
    Healthbar Number
    Flags 
        Armor
        Ping
        Fake
        LC
    Glow
    Glow Passes
    Glow Full Bloom
--]]