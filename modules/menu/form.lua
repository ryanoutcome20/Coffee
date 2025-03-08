
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
        'Serverside'    
    } )
    self:GenerateMiniCheckbox( nil, 'Hide Shots', 'aimbot_silent_hide' )

    self:GenerateCheckbox( Panel, 'Delay Shots', 'aimbot_delay' )
    self:GenerateSlider( nil, 'aimbot_delay_time', 1, 1000, 500, 0, false, 'ms' )

    self:GenerateCheckbox( Panel, 'Compensate Recoil', 'aimbot_norecoil' )

    self:GenerateCheckbox( Panel, 'Compensate Spread', 'aimbot_nospread' )

    self:GenerateCheckbox( Panel, 'Engine Prediction', 'aimbot_engine' )

    self:GenerateCheckbox( Panel, 'Autostop', 'aimbot_autostop' )
    self:GenerateKeybind( nil, 'aimbot_autostop_keybind' )
    self:GenerateSlider( nil, 'aimbot_autostop_speed', 1, 250, 125, 0, false, '' )

    self:GenerateCheckbox( Panel, 'Strip Run', 'aimbot_strip_run' )

    self:GenerateCheckbox( Panel, 'Resolver', 'aimbot_resolver' )
    self:GenerateDropdown( nil, 1, 'aimbot_resolver_mode', {
        'Normal',
        'Extended'    
    } )
    self:GenerateMiniCheckbox( nil, 'Only When Detected', 'aimbot_resolver_only_detect' )
    self:GenerateMiniCheckbox( nil, 'Use Serverside', 'aimbot_resolver_serverside' )

    self:GenerateCheckbox( Panel, 'Backtracking', 'aimbot_backtrack' )
    self:GenerateMiniCheckbox( nil, 'Inverse Records', 'aimbot_inverse' )

    self:GenerateCheckbox( Panel, 'Log Spread Misses', 'aimbot_log_spread' )
    
    self:GenerateCheckbox( Panel, 'Log Desync Misses', 'aimbot_log_desync' )
end )

Coffee.Menu:Handle( 'Aimbot', function( self, Panel )
    self:GenerateLabel( Panel, 'Hitboxes' )
    self:GenerateMiniCheckbox( nil, 'Feet', 'aimbot_hitboxes_feet' )
    self:GenerateMiniCheckbox( nil, 'Arms', 'aimbot_hitboxes_arms' )
    self:GenerateMiniCheckbox( nil, 'Stomach', 'aimbot_hitboxes_stomach' )
    self:GenerateMiniCheckbox( nil, 'Chest', 'aimbot_hitboxes_chest' )
    self:GenerateMiniCheckbox( nil, 'Head', 'aimbot_hitboxes_head' )
    self:GenerateMiniCheckbox( nil, 'Generic', 'aimbot_hitboxes_generic' )

    self:GenerateCheckbox( Panel, 'Multipoints', 'aimbot_multipoint' )

    self:GenerateLabel( Panel, 'Head Scale' )
    self:GenerateSlider( nil, 'aimbot_multipoint_head_scale', 1, 100, 75, 0, false, '%' )

    self:GenerateLabel( Panel, 'Other Scale' )
    self:GenerateSlider( nil, 'aimbot_multipoint_other_scale', 1, 100, 45, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Ignore Moving Limbs', 'aimbot_ignore_moving_limbs' )

    self:GenerateCheckbox( Panel, 'Ignore Head Airbourne', 'aimbot_ignore_airbourne_head' )

    self:GenerateCheckbox( Panel, 'Ignore Sticky', 'aimbot_ignore_sticky' )

    self:GenerateCheckbox( Panel, 'Invert Hitbox Selection', 'aimbot_invert_hitboxes' )

    self:GenerateLabel( Panel, 'Avoid' )
    self:GenerateMiniCheckbox( nil, 'Teammates', 'aimbot_avoid_teammates' )
    self:GenerateMiniCheckbox( nil, 'Buildmode', 'aimbot_avoid_buildmode' )
    self:GenerateMiniCheckbox( nil, 'Steam Friends', 'aimbot_avoid_steam_friends' )
    self:GenerateMiniCheckbox( nil, 'Noclip', 'aimbot_avoid_noclip' )
    self:GenerateMiniCheckbox( nil, 'Vehicles', 'aimbot_avoid_vehicles' )
    self:GenerateMiniCheckbox( nil, 'Invisible', 'aimbot_avoid_invisible' )
    self:GenerateMiniCheckbox( nil, 'Bots', 'aimbot_avoid_bots' )
end, true )

-- Anti-Aim Tab

Coffee.Menu:Handle( 'Anti-Aim', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enabled', 'hvh_enabled' )

    self:GenerateCheckbox( Panel, 'Adjust Pitch', 'hvh_pitch' )
    self:GenerateDropdown( nil, 1, 'hvh_pitch_mode', {
        'Emotion',
        'Down',
        'Up',
        'Zero',
        'Fake Down',
        'Fake Up',
        'Fake Jitter'
    }, 70 )

    self:GenerateCheckbox( Panel, 'Adjust Yaw', 'hvh_yaw' )
    self:GenerateKeybind( nil, 'hvh_yaw_invert' )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_base', {
        'Crosshair',
        'Distance',
        'Static'
    }, 70 )

    self:GenerateLabel( Panel, 'Yaw Add' )
    self:GenerateSlider( nil, 'hvh_yaw_add', -180, 180, 0, 0, false, '°' )

    self:GenerateCheckbox( Panel, 'Jitter', 'hvh_jitter' )
    self:GenerateSlider( nil, 'hvh_jitter_angle', -180, 180, 0, 0, false, '°' )
    self:GenerateMiniCheckbox( nil, 'Center Jitter', 'hvh_jitter_center' )

    self:GenerateCheckbox( Panel, 'Distortion', 'hvh_yaw_distortion' )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_distortion_timer', {
        'Current Time',
        'System Time'
    }, 80 )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_distortion_trigonometric', {
        'Sine',
        'Cosine',
        'Tangent'
    }, 70 )
    self:GenerateMiniCheckbox( nil, 'Force Turn', 'hvh_yaw_distortion_force' )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'hvh_yaw_distortion_speed', 0, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Divisor' )
    self:GenerateSlider( nil, 'hvh_yaw_distortion_divisor', 1, 10, 5, 0, false, '' )

    self:GenerateCheckbox( Panel, 'Fake Flick', 'hvh_yaw_flick' )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_flick_timer', {
        'Current Time',
        'System Time'
    }, 80 )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_flick_trigonometric', {
        'Sine',
        'Cosine',
        'Tangent'
    }, 70 )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'hvh_yaw_flick_speed', 0, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Angle' )
    self:GenerateSlider( nil, 'hvh_yaw_flick_angle', -90, 90, 0, 0, false, '°' )
    self:GenerateMiniCheckbox( nil, 'Use Desynced Rotation', 'hvh_yaw_flick_desync' )

    self:GenerateCheckbox( Panel, 'Flip Packets', 'hvh_yaw_flip_packets' )
end )

Coffee.Menu:Handle( 'Anti-Aim', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Fakelag', 'hvh_fakelag' )
    self:GenerateSlider( nil, 'hvh_fakelag_ticks', 1, 23, 1, 0, false, '' )
    self:GenerateMiniCheckbox( nil, 'Choke Shots', 'hvh_fakelag_shots' )

    self:GenerateCheckbox( Panel, 'Speedhack', 'hvh_speedhack' )
    self:GenerateKeybind( nil, 'hvh_speedhack_keybind' )
    self:GenerateSlider( nil, 'hvh_speedhack_ticks', 1, 23, 1, 0, false, '' )
    
    self:GenerateCheckbox( Panel, 'Lag Switch', 'hvh_lagswitch' )
    self:GenerateKeybind( nil, 'hvh_lagswitch_keybind' )
    self:GenerateMiniCheckbox( nil, 'Force Packets', 'hvh_lagswitch_force_packets' )

    self:GenerateLabel( Panel, 'Ticks' )
    self:GenerateSlider( nil, 'hvh_lagswitch_ticks', 1, 23, 1, 0, false, '' )
    
    self:GenerateLabel( Panel, 'Hold Time' )
    self:GenerateSlider( nil, 'hvh_lagswitch_hold_time', 1, 23, 1, 0, false, '' )

    self:GenerateCheckbox( Panel, 'Adjust Animations', 'hvh_animations' )
    self:GenerateMiniCheckbox( nil, 'Local Jelly', 'hvh_animations_jelly' )
    self:GenerateMiniCheckbox( nil, 'Force Slide', 'hvh_animations_force_slide' )
    self:GenerateMiniCheckbox( nil, 'Break Arms', 'hvh_animations_break_arms' )
    self:GenerateMiniCheckbox( nil, 'Spam Act', 'hvh_animations_spam_act' )

    self:GenerateCheckbox( Panel, 'Adjust Body Scale', 'hvh_animations_scale' )
    self:GenerateSlider( nil, 'hvh_animations_scale_amount', 1, 200, 100, 0, false, '%' )
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
    self:GenerateMiniCheckbox( nil, 'Self Illumination', 'esp_glow_self_illumination' )
    self:GenerateMiniCheckbox( nil, 'Render Weapon', 'esp_glow_weapon' )
    self:GenerateSlider( nil, 'esp_glow_passes', 1, 5, 3, 0 )

    self:GenerateCheckbox( Panel, 'Add Secondary Overlay', 'esp_glow_overlay'  )
    self:GenerateColorpicker( nil, 'esp_glow_overlay_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Bloom', 'esp_glow_overlay_bloom' )
    self:GenerateMiniCheckbox( nil, 'Self Illumination', 'esp_glow_overlay_self_illumination' )

    self:GenerateCheckbox( Panel, 'Add Material Overlay', 'esp_glow_material_overlay'  )
    self:GenerateColorpicker( nil, 'esp_glow_material_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_glow_material_overlay_material', {
        'Animated Plasma',
        'Wireframe',
        'Stars'
    } )

    self:GenerateCheckbox( Panel, 'Add Pulsation', 'esp_glow_pulsate'  )
    self:GenerateSlider( nil, 'esp_glow_pulsate_scale', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Add Blur', 'esp_glow_rim'  )
    self:GenerateMiniCheckbox( nil, 'Scale Passes', 'esp_glow_rim_scaled' )

    self:GenerateLabel( Panel, 'X Coordinate' )
    self:GenerateSlider( nil, 'esp_glow_rim_x', 1, 10, 5, 0 )
    self:GenerateMiniCheckbox( nil, 'Suppress', 'esp_glow_rim_x_suppress' )

    self:GenerateLabel( Panel, 'Y Coordinate' )
    self:GenerateSlider( nil, 'esp_glow_rim_y', 1, 10, 5, 0 )
    self:GenerateMiniCheckbox( nil, 'Suppress', 'esp_glow_rim_y_suppress' )

    self:GenerateCheckbox( Panel, 'Ring', 'esp_ring'  )
    self:GenerateColorpicker( nil, 'esp_ring_color', self.Colors.Main )

    self:GenerateLabel( Panel, 'Ring Time' )
    self:GenerateSlider( nil, 'esp_ring_time', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Ring Start Radius' )
    self:GenerateSlider( nil, 'esp_ring_start_radius', 1, 500, 250, 0 )

    self:GenerateLabel( Panel, 'Ring End Radius' )
    self:GenerateSlider( nil, 'esp_ring_end_radius', 1, 500, 250, 0 )

    self:GenerateLabel( Panel, 'Ring Width' )
    self:GenerateSlider( nil, 'esp_ring_width', 1, 6, 3, 0 )

    self:GenerateLabel( Panel, 'Ring Amplitude' )
    self:GenerateSlider( nil, 'esp_ring_amplitude', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Area Light', 'esp_light'  )
    self:GenerateColorpicker( nil, 'esp_light_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Use ELight', 'esp_light_elight'  )
    self:GenerateMiniCheckbox( nil, 'Use Pulse', 'esp_light_flicker'  )
    self:GenerateSlider( nil, 'esp_light_size', 1, 100, 1, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Visualize Footsteps', 'esp_footstep_visualize'  )
    self:GenerateColorpicker( nil, 'esp_footstep_visualize_left', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_footstep_visualize_right', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Force LOD', 'esp_lod'  )
    self:GenerateSlider( nil, 'esp_lod_number', 1, 8, 1, 0 )

    self:GenerateCheckbox( Panel, 'Localplayer Indicators', 'esp_indicators'  )
    self:GenerateMiniCheckbox( nil, 'Lag Compensation', 'esp_indicators_lc'  )
    self:GenerateMiniCheckbox( nil, 'Choke', 'esp_indicators_choke'  )
    self:GenerateMiniCheckbox( nil, 'Anti-Aim Inversion', 'esp_indicators_invert'  )
end )

Coffee.Menu:Handle( 'Players', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enemy Visible', 'esp_chams_enemy_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_enemy_visible_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Enemy Visible Overlay', 'esp_chams_enemy_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Enemy Invisible', 'esp_chams_enemy_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_enemy_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Enemy Invisible Overlay', 'esp_chams_enemy_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Enemy Backtrack', 'esp_chams_enemy_backtrack'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_enemy_backtrack_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Enemy Backtrack Overlay', 'esp_chams_enemy_backtrack_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_backtrack_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )


    self:GenerateCheckbox( Panel, 'Friendly Visible', 'esp_chams_friendly_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_friendly_visible_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Friendly Visible Overlay', 'esp_chams_friendly_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Friendly Invisible', 'esp_chams_friendly_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_friendly_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Friendly Invisible Overlay', 'esp_chams_friendly_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Friendly Backtrack', 'esp_chams_friendly_backtrack'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_color', self.Colors.Black )
    self:GenerateDropdown( nil, 2, 'esp_chams_friendly_backtrack_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Friendly Backtrack Overlay', 'esp_chams_friendly_backtrack_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_backtrack_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )


    self:GenerateCheckbox( Panel, 'Local Real', 'esp_chams_local'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Local Real Overlay', 'esp_chams_local_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Local Fake', 'esp_chams_local_fake'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_local_fake_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Local Fake Overlay', 'esp_chams_local_fake_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_fake_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )


    self:GenerateCheckbox( Panel, 'Viewmodel', 'esp_chams_viewmodel'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_viewmodel_original' )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Refracted',
        'Animated Portal',
        'Animated Water'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Viewmodel Overlay', 'esp_chams_viewmodel_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_overlay_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Highlight Wireframe',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Teleport'
    }, 80 )
end, true )

-- World Tab

Coffee.Menu:Handle( 'World', function( self, Panel )

end )

Coffee.Menu:Handle( 'World', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Footstep Manipulation', 'world_footstep' )

    self:GenerateLabel( Panel, 'Local Volume' )
    self:GenerateSlider( nil, 'world_footstep_local_volume', 1, 100, 50, 0, false, '%' )
    self:GenerateMiniCheckbox( nil, 'Suppress', 'world_footstep_local_suppress' )

    self:GenerateLabel( Panel, 'Other Volume' )
    self:GenerateSlider( nil, 'world_footstep_other_volume', 1, 100, 50, 0, false, '%' )
    self:GenerateMiniCheckbox( nil, 'Suppress', 'world_footstep_other_suppress' )

    self:GenerateCheckbox( Panel, 'Manipulation DSP', 'world_footstep_dsp' )
    self:GenerateSlider( nil, 'world_footstep_dsp_index', 2, 60, 30, 0 )

    self:GenerateCheckbox( Panel, 'Extend Range', 'world_footstep_range' )
    
    self:GenerateCheckbox( Panel, 'Impact Boxes', 'world_impacts' )
    self:GenerateColorpicker( nil, 'world_impacts_server', self.Colors.Blue )
    self:GenerateColorpicker( nil, 'world_impacts_client', self.Colors.Red )
    self:GenerateSlider( nil, 'world_impacts_time', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Render Spreadless Impacts', 'world_impacts_spreadless' )
    self:GenerateColorpicker( nil, 'world_impacts_spreadless_color', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Impact Beams', 'world_beams' )
    self:GenerateColorpicker( nil, 'world_beams_normal_main', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_beams_normal_secondary', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_beams_hurt_main', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_beams_hurt_secondary', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Use Traced', 'world_beams_traced' )

    self:GenerateLabel( Panel, 'Beam Time' )
    self:GenerateSlider( nil, 'world_beams_time', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Beam Width' )
    self:GenerateSlider( nil, 'world_beams_width', 1, 6, 3, 0 )

    self:GenerateLabel( Panel, 'Beam Segments' )
    self:GenerateSlider( nil, 'world_beams_segments', 1, 50, 25, 0 )

    self:GenerateLabel( Panel, 'Beam Speed' )
    self:GenerateSlider( nil, 'world_beams_speed', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Beam Twist' )
    self:GenerateSlider( nil, 'world_beams_twist', 1, 100, 50, 0, false, '%' )
    
    self:GenerateLabel( Panel, 'Beam Cone' )
    self:GenerateSlider( nil, 'world_beams_cone', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Beam Amplitude' )
    self:GenerateSlider( nil, 'world_beams_amplitude', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Local Update Visualizer', 'world_update' )
    self:GenerateColorpicker( nil, 'world_update_current_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_update_line_color', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Thirdperson', 'world_thirdperson' )
    self:GenerateKeybind( nil, 'world_thirdperson_keybind' )
    self:GenerateSlider( nil, 'world_thirdperson_distance', 1, 250, 125, 0 )

    self:GenerateCheckbox( Panel, 'Viewmodel Adjustments', 'world_viewmodel' )
    self:GenerateMiniCheckbox( nil, 'No Sway', 'world_viewmodel_sway' )
    self:GenerateMiniCheckbox( nil, 'No Bob', 'world_viewmodel_bob' )
    self:GenerateMiniCheckbox( nil, 'No Recoil', 'world_viewmodel_recoil' )
    self:GenerateMiniCheckbox( nil, 'Enforce Gamemode View', 'world_viewmodel_gamemode_view' )
    
    self:GenerateCheckbox( Panel, 'Visualize Aimbot', 'world_viewmodel_visualize_aimbot' )
    
    self:GenerateCheckbox( Panel, 'Override FOV', 'world_fov' )
    self:GenerateSlider( nil, 'world_fov_amount', 0, 150, 75, 0 )

    self:GenerateCheckbox( Panel, 'Override Offsets', 'world_offsets' )
    
    self:GenerateLabel( Panel, 'X Coordinate' )
    self:GenerateSlider( nil, 'world_offsets_x', -60, 60, 0, 0, false, '°' )

    self:GenerateLabel( Panel, 'Y Coordinate' )
    self:GenerateSlider( nil, 'world_offsets_y', -60, 60, 0, 0, false, '°' )

    self:GenerateLabel( Panel, 'Z Coordinate' )
    self:GenerateSlider( nil, 'world_offsets_z', -60, 60, 0, 0, false, '°' )

    self:GenerateLabel( Panel, 'Pitch' )
    self:GenerateSlider( nil, 'world_offsets_pitch', -180, 180, 0, 0, false, '°' )

    self:GenerateLabel( Panel, 'Yaw' )
    self:GenerateSlider( nil, 'world_offsets_yaw', -180, 180, 0, 0, false, '°' )

    self:GenerateLabel( Panel, 'Roll' )
    self:GenerateSlider( nil, 'world_offsets_roll', -180, 180, 0, 0, false, '°' )

end, true )

-- Miscellaneous Tab

Coffee.Menu:Handle( 'Miscellaneous', function( self, Panel )
    self:GenerateLabel( Panel, 'Menu Color' )
    self:GenerateColorpicker( nil, 'miscellaneous_menu', self.Color, function( Color )
        self.Color = Color
    end )

    self:GenerateCheckbox( Panel, 'Watermark', 'miscellaneous_watermark'  )

    self:GenerateCheckbox( Panel, 'Notifications', 'miscellaneous_notifications'  )
    self:GenerateMiniCheckbox( nil, 'Outgoing Damage', 'miscellaneous_notifications_outgoing' )
    self:GenerateMiniCheckbox( nil, 'Incoming Damage', 'miscellaneous_notifications_incoming' )
    self:GenerateMiniCheckbox( nil, 'Connections', 'miscellaneous_notifications_join' )
    self:GenerateMiniCheckbox( nil, 'Disconnections', 'miscellaneous_notifications_leave' )

end )

Coffee.Menu:Handle( 'Miscellaneous', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Walkbot', 'miscellaneous_movement_bot'  )
    self:GenerateKeybind( nil, 'miscellaneous_movement_bot_keybind' )

    self:GenerateLabel( Panel, 'Max Prediction Ticks' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_ticks', 1, 50, 25, 0 )

    self:GenerateLabel( Panel, 'Workable Direction Distance' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_distance', 1, 800, 400, 0 )

    self:GenerateLabel( Panel, 'Target Velocity' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_velocity', 0, 200, 100, 0 )

    self:GenerateCheckbox( Panel, 'Handle Smooth Ramps', 'miscellaneous_movement_bot_ramps'  )

    self:GenerateLabel( Panel, 'Floor Offset' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_ramps_offset', 0, 20, 10, 0 )

    self:GenerateLabel( Panel, 'Ramp Distance' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_ramps_distance', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Ramp Angle' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_ramps_angle', 1, 130, 65, 0, false, '°' )

    self:GenerateCheckbox( Panel, 'Handle Steps', 'miscellaneous_movement_bot_step'  )
    
    self:GenerateLabel( Panel, 'Ramp Distance' )
    self:GenerateSlider( nil, 'miscellaneous_movement_bot_step_distance', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Pointbot', 'miscellaneous_point_bot'  )
    self:GenerateKeybind( nil, 'miscellaneous_point_bot_keybind' )
    self:GenerateMiniCheckbox( nil, 'Invert On Final', 'miscellaneous_point_bot_invert' )

    self:GenerateButton( Panel, 'Add Point', function( )
        Coffee.Bots.Point:InsertPoint( )
    end )

    self:GenerateButton( Panel, 'Remove First Point', function( )
        Coffee.Bots.Point:RemovePoint( true )
    end )

    self:GenerateButton( Panel, 'Remove Last Point', function( )
        Coffee.Bots.Point:RemovePoint( false )
    end )

    self:GenerateButton( Panel, 'Clear All Points', function( )
        Coffee.Bots.Point:ClearPoints( )
    end )

    self:GenerateCheckbox( Panel, 'Render Points', 'miscellaneous_point_bot_render'  )
    self:GenerateColorpicker( nil, 'miscellaneous_point_bot_render_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Draw Number', 'miscellaneous_point_bot_render_number' )
end, true )