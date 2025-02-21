
-- Aimbot Tab

Coffee.Menu:Handle( 'Aimbot', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enabled', 'aimbot_enabled' )
    self:GenerateKeybind( nil, 'aimbot_enabled_keybind', true )

    self:GenerateCheckbox( Panel, 'Autofire', 'aimbot_autofire' )
    self:GenerateDropdown( nil, 1, 'aimbot_autofire_mode', {
        'Left',
        'Right',
        'Both'
    } )

    self:GenerateCheckbox( Panel, 'Silent', 'aimbot_silent' )
    self:GenerateDropdown( nil, 1, 'aimbot_silent_mode', {
        'Clientside',
        'Serverside',
        'Paneled'
    } )
    self:GenerateMiniCheckbox( nil, 'Hide Shots', 'aimbot_silent_hide' )

    self:GenerateCheckbox( Panel, 'Delay Shots', 'aimbot_delay' )
    self:GenerateSlider( nil, 'aimbot_delay_time', 1, 1000, 500, 0, false, 'ms' )

    self:GenerateCheckbox( Panel, 'Hitchance', 'aimbot_hitchance' )
    self:GenerateSlider( nil, 'aimbot_hitchance_value', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Compensate Recoil', 'aimbot_norecoil' )

    self:GenerateCheckbox( Panel, 'Compensate Spread', 'aimbot_nospread' )

    self:GenerateCheckbox( Panel, 'Autostop', 'aimbot_autostop' )
    self:GenerateDropdown( nil, 1, 'aimbot_autostop_mode', {
        'Partial',
        'Fullstop'
    } )

    self:GenerateCheckbox( Panel, 'Resolver', 'aimbot_resolver' )
    self:GenerateMiniCheckbox( nil, 'Only When Detected', 'aimbot_resolver_only_detect' )
    self:GenerateMiniCheckbox( nil, 'Use Serverside', 'aimbot_resolver_serverside' )
end )

Coffee.Menu:Handle( 'Aimbot', function( self, Panel )
    self:GenerateLabel( Panel, 'Hitboxes' )
    self:GenerateMiniCheckbox( nil, 'Head', 'aimbot_hitboxes_head' )
    self:GenerateMiniCheckbox( nil, 'Chest', 'aimbot_hitboxes_chest' )
    self:GenerateMiniCheckbox( nil, 'Stomach', 'aimbot_hitboxes_stomach' )
    self:GenerateMiniCheckbox( nil, 'Arms', 'aimbot_hitboxes_arms' )
    self:GenerateMiniCheckbox( nil, 'Feet', 'aimbot_hitboxes_feet' )
    self:GenerateMiniCheckbox( nil, 'Generic', 'aimbot_hitboxes_generic' )

    self:GenerateCheckbox( Panel, 'Multipoints', 'aimbot_multipoint' )
    self:GenerateMiniCheckbox( nil, 'Head', 'aimbot_multipoint_head' )
    self:GenerateMiniCheckbox( nil, 'Chest', 'aimbot_multipoint_chest' )
    self:GenerateMiniCheckbox( nil, 'Stomach', 'aimbot_multipoint_stomach' )
    self:GenerateMiniCheckbox( nil, 'Arms', 'aimbot_multipoint_arms' )
    self:GenerateMiniCheckbox( nil, 'Feet', 'aimbot_multipoint_feet' )
    self:GenerateMiniCheckbox( nil, 'Generic', 'aimbot_multipoint_generic' )

    self:GenerateLabel( Panel, 'Head Scale' )
    self:GenerateSlider( nil, 'aimbot_multipoint_head_scale', 1, 100, 75, 0, false, '%' )

    self:GenerateLabel( Panel, 'Other Scale' )
    self:GenerateSlider( nil, 'aimbot_multipoint_other_scale', 1, 100, 45, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Ignore Moving Limbs', 'aimbot_ignore_moving_limbs' )

    self:GenerateCheckbox( Panel, 'Ignore Sticky', 'aimbot_ignore_sticky' )

    self:GenerateLabel( Panel, 'Avoid' )
    self:GenerateMiniCheckbox( nil, 'Teammates', 'aimbot_avoid_teammates' )
    self:GenerateMiniCheckbox( nil, 'Buildmode', 'aimbot_avoid_buildmode' )
    self:GenerateMiniCheckbox( nil, 'Steam Friends', 'aimbot_avoid_steam_friends' )
    self:GenerateMiniCheckbox( nil, 'Noclip', 'aimbot_avoid_noclip' )
    self:GenerateMiniCheckbox( nil, 'Vehicles', 'aimbot_avoid_vehicles' )
    self:GenerateMiniCheckbox( nil, 'Invisible', 'aimbot_avoid_invisible' )
    self:GenerateMiniCheckbox( nil, 'Bots', 'aimbot_avoid_bots' )
    self:GenerateMiniCheckbox( nil, 'NPCs', 'aimbot_avoid_npcs' )
    self:GenerateMiniCheckbox( nil, 'Players', 'aimbot_avoid_players' )
end, true )

-- Players Tab

Coffee.Menu:Handle( 'Players', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enabled', 'esp_enabled' )
    self:GenerateKeybind( nil, 'esp_enabled_keybind', true )
    self:GenerateMiniCheckbox( nil, 'Draw Enemies', 'esp_enemy' )
    self:GenerateMiniCheckbox( nil, 'Draw Teammates', 'esp_team' )
    self:GenerateMiniCheckbox( nil, 'Draw Local', 'esp_local' )
   
    self:GenerateCheckbox( Panel, 'Visualize Updates', 'esp_server' )
    self:GenerateCheckbox( Panel, 'Visualize Dead', 'esp_visualize_dead' )
    self:GenerateCheckbox( Panel, 'Visualize Dormancy', 'esp_visualize_dormant' )

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
    self:GenerateDropdown( nil, 1, 'esp_name_font', {
        'Main',
        'Small'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Weapon', 'esp_weapon'  )
    self:GenerateColorpicker( nil, 'esp_weapon_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Use smart language model', 'esp_weapon_smart'  )
    self:GenerateDropdown( nil, 4, 'esp_weapon_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )
    self:GenerateDropdown( nil, 2, 'esp_weapon_font', {
        'Main',
        'Small'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Healthbar', 'esp_healthbar'  )
    self:GenerateMiniCheckbox( nil, 'Flip direction', 'esp_healthbar_direction'  )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_dock', {
        'Left',
        'Right'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Override Healthbar Color', 'esp_healthbar_override'  )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_down', self.Colors.Main )
    
    self:GenerateCheckbox( Panel, 'Healthbar Number', 'esp_healthbar_number'  )
    self:GenerateColorpicker( nil, 'esp_healthbar_number_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_number_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )
    self:GenerateDropdown( nil, 2, 'esp_healthbar_number_font', {
        'Main',
        'Small'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Armorbar', 'esp_armorbar'  )
    self:GenerateColorpicker( nil, 'esp_armorbar_override_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_armorbar_override_down', self.Colors.Cyan )
    self:GenerateMiniCheckbox( nil, 'Always Show', 'esp_armorbar_always' )
    self:GenerateMiniCheckbox( nil, 'Flip direction', 'esp_armorbar_direction'  )
    self:GenerateDropdown( nil, 1, 'esp_armorbar_dock', {
        'Left',
        'Right'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Armorbar Number', 'esp_armorbar_number'  )
    self:GenerateColorpicker( nil, 'esp_armorbar_number_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_armorbar_number_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )
    self:GenerateDropdown( nil, 2, 'esp_armorbar_number_font', {
        'Main',
        'Small'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Ping', 'esp_ping'  )
    self:GenerateColorpicker( nil, 'esp_ping_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_ping_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Fake', 'esp_fake'  )
    self:GenerateColorpicker( nil, 'esp_fake_color_good', self.Colors.Green )
    self:GenerateColorpicker( nil, 'esp_fake_color_bad', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_fake_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Lag Compensation', 'esp_lc'  )
    self:GenerateColorpicker( nil, 'esp_lc_color_good', self.Colors.Green )
    self:GenerateColorpicker( nil, 'esp_lc_color_bad', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_lc_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Dead', 'esp_dead'  )
    self:GenerateColorpicker( nil, 'esp_dead_color', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_dead_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 50 )

    self:GenerateCheckbox( Panel, 'Glow', 'esp_glow'  )
    self:GenerateColorpicker( nil, 'esp_glow_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Bloom', 'esp_glow_bloom' )
    self:GenerateMiniCheckbox( nil, 'Render Weapon', 'esp_glow_weapon' )
    self:GenerateSlider( nil, 'esp_glow_passes', 1, 5, 3, 0 )

    self:GenerateCheckbox( Panel, 'Force LOD', 'esp_lod'  )
    self:GenerateSlider( nil, 'esp_lod_number', 1, 8, 1, 0 )

end )

Coffee.Menu:Handle( 'Players', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enemy Visible', 'esp_chams_enemy_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_enemy_visible_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Visible Overlay', 'esp_chams_enemy_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Invisible', 'esp_chams_enemy_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_enemy_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Invisible Overlay', 'esp_chams_enemy_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )


    self:GenerateCheckbox( Panel, 'Friendly Visible', 'esp_chams_friendly_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_friendly_visible_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Visible Overlay', 'esp_chams_friendly_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Invisible', 'esp_chams_friendly_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_friendly_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Invisible Overlay', 'esp_chams_friendly_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )


    self:GenerateCheckbox( Panel, 'Local Real', 'esp_chams_local'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_local_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Local Real Overlay', 'esp_chams_local_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )

    self:GenerateCheckbox( Panel, 'Local Fake', 'esp_chams_local_fake'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_local_fake_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Local Fake Overlay', 'esp_chams_local_fake_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_fake_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )


    self:GenerateCheckbox( Panel, 'Viewmodel', 'esp_chams_viewmodel'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_viewmodel_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow'
    } )

    self:GenerateCheckbox( Panel, 'Viewmodel Overlay', 'esp_chams_viewmodel_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars'
    } )
end, true )