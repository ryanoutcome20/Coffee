
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

    self:GenerateCheckbox( Panel, 'Continuous Fire', 'aimbot_continuous' )

    self:GenerateCheckbox( Panel, 'Minimum Damage', 'aimbot_minimum_damage' )
    self:GenerateSlider( nil, 'aimbot_minimum_damage_damage', 1, 100, 50, 0, false, 'hp' )

    self:GenerateCheckbox( Panel, 'Autowall', 'aimbot_autowall' )
    self:GenerateSlider( nil, 'aimbot_autowall_damage', 1, 100, 50, 0, false, 'hp' )

    self:GenerateCheckbox( Panel, 'Automatic Entity Penetration', 'aimbot_engine_entity' )
    self:GenerateSlider( nil, 'aimbot_engine_entity_damage', 1, 100, 50, 0, false, 'hp' )

    self:GenerateCheckbox( Panel, 'Compensate Recoil', 'aimbot_norecoil' )

    self:GenerateCheckbox( Panel, 'Compensate Spread', 'aimbot_nospread' )
    self:GenerateMiniCheckbox( nil, 'Use Engine Spread', 'aimbot_nospread_engine' )
    
    self:GenerateCheckbox( Panel, 'Seed Offset', 'aimbot_nospread_offset' )
    self:GenerateSlider( nil, 'aimbot_nospread_offset_seed', -255, 255, 0, 0 )

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

    self:GenerateCheckbox( Panel, 'Disable Interpolation', 'aimbot_interpolation' )

    self:GenerateCheckbox( Panel, 'Backtracking', 'aimbot_backtrack' )
    self:GenerateMiniCheckbox( nil, 'Inverse Records', 'aimbot_inverse' )

    self:GenerateCheckbox( Panel, 'Extend Interpolation', 'aimbot_extended' )
    self:GenerateSlider( nil, 'aimbot_extended_time', 200, 1000, 500, 0 )

    self:GenerateCheckbox( Panel, 'Shot Matrix', 'aimbot_shot_matrix' )
    self:GenerateColorpicker( nil, 'aimbot_shot_matrix_color', self.Colors.Gray )
    self:GenerateSlider( nil, 'aimbot_shot_matrix_time', 1, 10, 5, 1 )
    self:GenerateMiniCheckbox( nil, 'Singular', 'aimbot_shot_matrix_singular'  )

    self:GenerateCheckbox( Panel, 'Log Spread Misses', 'aimbot_log_spread' )
    
    self:GenerateCheckbox( Panel, 'Log Desync Misses', 'aimbot_log_desync' )

    self:GenerateCheckbox( Panel, 'Optimizations', 'aimbot_optimizations' )
    self:GenerateMiniCheckbox( nil, 'Avoid Generating Hitbox Matrixes', 'aimbot_optimizations_hitboxes' )
    self:GenerateMiniCheckbox( nil, 'Simple Record Selection', 'aimbot_optimizations_records' )
    self:GenerateMiniCheckbox( nil, 'Avoid Multiple Records', 'aimbot_optimizations_small_records' )
    self:GenerateMiniCheckbox( nil, 'Limit Aimbot Scan', 'aimbot_optimizations_targets' )
    self:GenerateMiniCheckbox( nil, 'Avoid Ideal Record Scan', 'aimbot_optimizations_ideal_records' )

    self:GenerateLabel( Panel, 'Optimize Scan' )
    self:GenerateSlider( nil, 'aimbot_optimizations_targets_amount', 1, 3, 2, 0 )

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
    self:GenerateMiniCheckbox( nil, 'Invert', 'aimbot_always_sticky' )

    self:GenerateCheckbox( Panel, 'Invert Hitbox Selection', 'aimbot_invert_hitboxes' )

    self:GenerateCheckbox( Panel, 'Ignore LOS', 'aimbot_ignore_los' )

    self:GenerateCheckbox( Panel, 'Compensate Grenade Lag', 'aimbot_grenade' )
    self:GenerateKeybind( nil, 'aimbot_grenade_keybind' )
    self:GenerateSlider( nil, 'aimbot_grenade_distance', -100, 100, 0, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'World Sphere FOV', 'aimbot_world_sphere' )
    self:GenerateSlider( nil, 'aimbot_world_sphere_fov', 1, 2500, 1250, 0 )
    self:GenerateMiniCheckbox( nil, 'Use OBB Range', 'aimbot_obb_range' )

    self:GenerateCheckbox( Panel, 'Visualize World Sphere', 'aimbot_world_sphere_visualize' )
    self:GenerateColorpicker( nil, 'aimbot_world_sphere_visualize_color', self.Colors.Gray )
    self:GenerateSlider( nil, 'aimbot_world_sphere_visualize_step', 1, 20, 10, 0 )

    self:GenerateLabel( Panel, 'Blacklist' )
    self:GenerateMiniCheckbox( nil, 'Teammates', 'aimbot_avoid_teammates' )
    self:GenerateMiniCheckbox( nil, 'Buildmode', 'aimbot_avoid_buildmode' )
    self:GenerateMiniCheckbox( nil, 'Steam Friends', 'aimbot_avoid_steam_friends' )
    self:GenerateMiniCheckbox( nil, 'Noclip', 'aimbot_avoid_noclip' )
    self:GenerateMiniCheckbox( nil, 'Vehicles', 'aimbot_avoid_vehicles' )
    self:GenerateMiniCheckbox( nil, 'Invisible', 'aimbot_avoid_invisible' )
    self:GenerateMiniCheckbox( nil, 'Bots', 'aimbot_avoid_bots' )
    self:GenerateMiniCheckbox( nil, 'Hunters', 'aimbot_avoid_hunters' )
    self:GenerateMiniCheckbox( nil, 'Props', 'aimbot_avoid_props' )
    self:GenerateMiniCheckbox( nil, 'Deathmatch', 'aimbot_avoid_deathmatch' )

    self:GenerateCheckbox( Panel, 'Invert Blacklist', 'aimbot_avoid_invert' )
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
        'Away Targets',
        'Static'
    } )

    self:GenerateLabel( Panel, 'Yaw Add' )
    self:GenerateSlider( nil, 'hvh_yaw_add', -180, 180, 0, 0, false, '°' )

    self:GenerateCheckbox( Panel, 'Jitter', 'hvh_jitter' )
    self:GenerateSlider( nil, 'hvh_jitter_angle', -180, 180, 0, 0, false, '°' )
    self:GenerateMiniCheckbox( nil, 'Center Jitter', 'hvh_jitter_center' )

    self:GenerateCheckbox( Panel, 'Distortion', 'hvh_yaw_distortion' )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_distortion_timer', {
        'Current Time',
        'System Time'
    } )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_distortion_trigonometric', {
        'Sine',
        'Cosine',
        'Tangent'
    }, 70 )
    self:GenerateMiniCheckbox( nil, 'Force Turn', 'hvh_yaw_distortion_force' )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'hvh_yaw_distortion_speed', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Divisor' )
    self:GenerateSlider( nil, 'hvh_yaw_distortion_divisor', 1, 10, 5, 0, false, '' )

    self:GenerateLabel( Panel, 'Scale' )
    self:GenerateSlider( nil, 'hvh_yaw_distortion_scale', 1, 100, 5, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Fake Flick', 'hvh_yaw_flick' )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_flick_timer', {
        'Current Time',
        'System Time'
    } )
    self:GenerateDropdown( nil, 1, 'hvh_yaw_flick_trigonometric', {
        'Sine',
        'Cosine',
        'Tangent'
    }, 70 )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'hvh_yaw_flick_speed', 1, 100, 50, 0, false, '%' )

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
    self:GenerateMiniCheckbox( nil, 'Airstuck', 'hvh_speedhack_airstuck' )

    self:GenerateCheckbox( Panel, 'Lag Switch', 'hvh_lagswitch' )
    self:GenerateKeybind( nil, 'hvh_lagswitch_keybind' )
    self:GenerateMiniCheckbox( nil, 'Force Packets', 'hvh_lagswitch_force_packets' )

    self:GenerateLabel( Panel, 'Ticks' )
    self:GenerateSlider( nil, 'hvh_lagswitch_ticks', 1, 23, 1, 0, false, '' )
    
    self:GenerateLabel( Panel, 'Hold Time' )
    self:GenerateSlider( nil, 'hvh_lagswitch_hold_time', 1, 23, 1, 0, false, '' )

    self:GenerateCheckbox( Panel, 'Network Abuse', 'hvh_networking' )
    self:GenerateKeybind( nil, 'hvh_networking_keybind', true )

    self:GenerateLabel( Panel, 'Lag' )
    self:GenerateSlider( nil, 'hvh_networking_lag', 0, 500, 250, 0 )
    
    self:GenerateLabel( Panel, 'Loss' )
    self:GenerateSlider( nil, 'hvh_networking_loss', 0, 150, 75, 0 )
    
    self:GenerateLabel( Panel, 'Jitter' )
    self:GenerateSlider( nil, 'hvh_networking_jitter', 0, 1000, 500, 0 )
    
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
    self:GenerateColorpicker( nil, 'esp_visualize_dormant_color', self.Colors.Gray )

    self:GenerateCheckbox( Panel, 'Limit Distance', 'esp_limit_distance'  )
    self:GenerateSlider( nil, 'esp_limit_distance_distance', 1, 10000, 5000, 0 )

    self:GenerateCheckbox( Panel, 'Box', 'esp_box' )
    self:GenerateColorpicker( nil, 'esp_box_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_box_color_outline', self.Colors.Black )
    self:GenerateDropdown( nil, 1, 'esp_box_type', {
        '2D',
        '3D'
    } )
    
    self:GenerateCheckbox( Panel, 'Fill Box', 'esp_box_fill' )
    self:GenerateColorpicker( nil, 'esp_box_fill_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_box_fill_down', self.Colors.Black )

    self:GenerateCheckbox( Panel, 'Name', 'esp_name' )
    self:GenerateColorpicker( nil, 'esp_name_color', self.Colors.White )
    self:GenerateDropdown( nil, 3, 'esp_name_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )
    self:GenerateDropdown( nil, 1, 'esp_name_font', {
        'Main',
        'Small'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Weapon', 'esp_weapon'  )
    self:GenerateColorpicker( nil, 'esp_weapon_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Use smart language model', 'esp_weapon_smart'  )
    self:GenerateDropdown( nil, 4, 'esp_weapon_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )
    self:GenerateDropdown( nil, 2, 'esp_weapon_font', {
        'Main',
        'Small'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Weapon Icon', 'esp_weapon_icon'  )
    self:GenerateColorpicker( nil, 'esp_weapon_icon_color', self.Colors.White )
    self:GenerateDropdown( nil, 4, 'esp_weapon_icon_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Healthbar', 'esp_healthbar'  )
    self:GenerateMiniCheckbox( nil, 'Flip direction', 'esp_healthbar_direction'  )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_dock', {
        'Left',
        'Right'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Override Healthbar', 'esp_healthbar_override'  )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_override_material', {
        'Gradient',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Animated Portal'
    } )
    self:GenerateMiniCheckbox( nil, 'Override Colors', 'esp_healthbar_override_color' )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_healthbar_override_down', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Healthbar Number', 'esp_healthbar_number'  )
    self:GenerateColorpicker( nil, 'esp_healthbar_number_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_healthbar_number_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )
    self:GenerateDropdown( nil, 2, 'esp_healthbar_number_font', {
        'Main',
        'Small'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Armorbar', 'esp_armorbar'  )
    self:GenerateMiniCheckbox( nil, 'Always Show', 'esp_armorbar_always' )
    self:GenerateMiniCheckbox( nil, 'Flip direction', 'esp_armorbar_direction'  )
    self:GenerateDropdown( nil, 1, 'esp_armorbar_dock', {
        'Left',
        'Right'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Override Armorbar', 'esp_armorbar_override'  )
    self:GenerateDropdown( nil, 1, 'esp_armorbar_override_material', {
        'Gradient',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )
    self:GenerateMiniCheckbox( nil, 'Override Colors', 'esp_armorbar_override_color' )
    self:GenerateColorpicker( nil, 'esp_armorbar_override_up', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_armorbar_override_down', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Armorbar Number', 'esp_armorbar_number'  )
    self:GenerateColorpicker( nil, 'esp_armorbar_number_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_armorbar_number_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )
    self:GenerateDropdown( nil, 2, 'esp_armorbar_number_font', {
        'Main',
        'Small'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Ping', 'esp_ping'  )
    self:GenerateColorpicker( nil, 'esp_ping_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_ping_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Fake', 'esp_fake'  )
    self:GenerateColorpicker( nil, 'esp_fake_color_good', self.Colors.Green )
    self:GenerateColorpicker( nil, 'esp_fake_color_bad', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_fake_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Lag Compensation', 'esp_lc'  )
    self:GenerateColorpicker( nil, 'esp_lc_color_good', self.Colors.Green )
    self:GenerateColorpicker( nil, 'esp_lc_color_bad', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_lc_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Dead', 'esp_dead'  )
    self:GenerateColorpicker( nil, 'esp_dead_color', self.Colors.Red )
    self:GenerateDropdown( nil, 2, 'esp_dead_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Dormant', 'esp_dormant'  )
    self:GenerateColorpicker( nil, 'esp_dormant_color', self.Colors.Gray )
    self:GenerateDropdown( nil, 2, 'esp_dormant_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'TTT', 'esp_ttt'  )
    self:GenerateColorpicker( nil, 'esp_ttt_traitor', self.Colors.Red )
    self:GenerateColorpicker( nil, 'esp_ttt_detective', self.Colors.Cyan )
    self:GenerateDropdown( nil, 2, 'esp_ttt_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Model', 'esp_model'  )
    self:GenerateColorpicker( nil, 'esp_model_color', self.Colors.White )
    self:GenerateDropdown( nil, 3, 'esp_model_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Usergroup', 'esp_usergroup'  )
    self:GenerateColorpicker( nil, 'esp_usergroup_color', self.Colors.White )
    self:GenerateDropdown( nil, 3, 'esp_usergroup_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Team', 'esp_team_name'  )
    self:GenerateColorpicker( nil, 'esp_team_name_color', self.Colors.White )
    self:GenerateDropdown( nil, 4, 'esp_team_name_dock', {
        'Left',
        'Right',
        'Top',
        'Bottom'
    }, 80 )

    self:GenerateCheckbox( Panel, 'Glow', 'esp_glow'  )
    self:GenerateColorpicker( nil, 'esp_glow_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Bloom', 'esp_glow_bloom' )
    self:GenerateMiniCheckbox( nil, 'Self Illumination', 'esp_glow_self_illumination' )
    self:GenerateMiniCheckbox( nil, 'Only Visible', 'esp_glow_only_visible' )
    self:GenerateMiniCheckbox( nil, 'Render Weapon', 'esp_glow_weapon' )
    self:GenerateSlider( nil, 'esp_glow_passes', 1, 5, 3, 0 )

    self:GenerateCheckbox( Panel, 'Add Secondary Overlay', 'esp_glow_overlay'  )
    self:GenerateColorpicker( nil, 'esp_glow_overlay_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Bloom', 'esp_glow_overlay_bloom' )
    self:GenerateMiniCheckbox( nil, 'Self Illumination', 'esp_glow_overlay_self_illumination' )
    self:GenerateMiniCheckbox( nil, 'Only Visible', 'esp_glow_overlay_only_visible' )

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

    self:GenerateLabel( Panel, 'Time' )
    self:GenerateSlider( nil, 'esp_ring_time', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Start Radius' )
    self:GenerateSlider( nil, 'esp_ring_start_radius', 1, 500, 250, 0 )

    self:GenerateLabel( Panel, 'End Radius' )
    self:GenerateSlider( nil, 'esp_ring_end_radius', 1, 500, 250, 0 )
    self:GenerateMiniCheckbox( nil, 'Pulsate', 'esp_ring_end_radius_pulsate' )

    self:GenerateLabel( Panel, 'Width' )
    self:GenerateSlider( nil, 'esp_ring_width', -6, 6, 0, 0 )
    self:GenerateMiniCheckbox( nil, 'Pulsate', 'esp_ring_width_pulsate' )

    self:GenerateLabel( Panel, 'Amplitude' )
    self:GenerateSlider( nil, 'esp_ring_amplitude', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Area Light', 'esp_light'  )
    self:GenerateColorpicker( nil, 'esp_light_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Use ELight', 'esp_light_elight'  )
    self:GenerateMiniCheckbox( nil, 'Use Pulse', 'esp_light_flicker'  )
    self:GenerateSlider( nil, 'esp_light_size', 1, 100, 1, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Headbeam', 'esp_headbeam'  )
    self:GenerateColorpicker( nil, 'esp_headbeam_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_headbeam_material', {
        'Physbeam',
        'Laser',
        'Lightning',
        'Plasma',
        'Smoke',
        'Beam'
    } )

    self:GenerateCheckbox( Panel, 'Visualize Records', 'esp_visualized_records'  )
    self:GenerateColorpicker( nil, 'esp_visualized_records_color', self.Colors.Main )
    self:GenerateDropdown( nil, 1, 'esp_visualized_records_mode', {
        'Line',
        'Dots',
        'Bounds'
    } )

    self:GenerateCheckbox( Panel, 'Blink Light', 'esp_blink'  )

    self:GenerateCheckbox( Panel, 'Remove Shadows', 'esp_remove_shadows'  )
    
    self:GenerateCheckbox( Panel, 'Visualize Footsteps', 'esp_footstep_visualize'  )
    self:GenerateColorpicker( nil, 'esp_footstep_visualize_left', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_footstep_visualize_right', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Force LOD', 'esp_lod'  )
    self:GenerateSlider( nil, 'esp_lod_number', 1, 8, 1, 0 )

    self:GenerateCheckbox( Panel, 'Optimized Visual Culling', 'esp_culled'  )

    self:GenerateCheckbox( Panel, 'Draw Local Firstperson', 'esp_first_person'  )
end )

Coffee.Menu:Handle( 'Players', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Enemy Visible', 'esp_chams_enemy_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_secondary_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_enemy_visible_original' )
    self:GenerateMiniCheckbox( nil, 'Draw Attachments', 'esp_chams_enemy_visible_attachments' )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Visible Overlay', 'esp_chams_enemy_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_visible_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Invisible', 'esp_chams_enemy_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_color', self.Colors.Black )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_enemy_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Invisible Overlay', 'esp_chams_enemy_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_invisible_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Backtrack', 'esp_chams_enemy_backtrack'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_color', self.Colors.Black )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_enemy_backtrack_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Enemy Backtrack Overlay', 'esp_chams_enemy_backtrack_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_enemy_backtrack_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_enemy_backtrack_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )


    self:GenerateCheckbox( Panel, 'Friendly Visible', 'esp_chams_friendly_visible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_secondary_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_friendly_visible_original' )
    self:GenerateMiniCheckbox( nil, 'Draw Attachments', 'esp_chams_friendly_visible_attachments' )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Visible Overlay', 'esp_chams_friendly_visible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_visible_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_visible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Invisible', 'esp_chams_friendly_invisible'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_color', self.Colors.Black )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_friendly_invisible_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Invisible Overlay', 'esp_chams_friendly_invisible_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_invisible_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_invisible_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Backtrack', 'esp_chams_friendly_backtrack'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_color', self.Colors.Black )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_friendly_backtrack_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Friendly Backtrack Overlay', 'esp_chams_friendly_backtrack_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_friendly_backtrack_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_friendly_backtrack_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )


    self:GenerateCheckbox( Panel, 'Local Real', 'esp_chams_local'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_chams_local_secondary_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Attachments', 'esp_chams_local_attachments' )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Local Real Overlay', 'esp_chams_local_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_local_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )

    self:GenerateCheckbox( Panel, 'Local Fake', 'esp_chams_local_fake'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 2, 'esp_chams_local_fake_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Local Fake Overlay', 'esp_chams_local_fake_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_local_fake_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_local_fake_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )


    self:GenerateCheckbox( Panel, 'Viewmodel', 'esp_chams_viewmodel'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_secondary_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Draw Original', 'esp_chams_viewmodel_original' )
    self:GenerateMiniCheckbox( nil, 'Avoid Passover Hands', 'esp_chams_viewmodel_original_no_hands' )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_material', {
        'Normal',
        'Flat',
        'Metal',
        'Glow',
        'Pearlescent',
        'Hue',
        'Cloud',
        'Cracked',
        'Animated Portal',
        'Animated Water',
        'Animated Shield'
    } )

    self:GenerateCheckbox( Panel, 'Viewmodel Overlay', 'esp_chams_viewmodel_overlay'  )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_overlay_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'esp_chams_viewmodel_overlay_secondary_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'esp_chams_viewmodel_overlay_material', {
        'Outline',
        'Wireframe',
        'Animated Wireframe',
        'Animated Plasma',
        'Stars',
        'Animated Portal',
        'Animated Spawn Effect',
        'Animated Wireframe Dots',
        'Animated Dots',
        'Animated Breathing',
        'Animated Fenceglow',
        'Animated Teleport'
    } )
end, true )

-- World Tab

Coffee.Menu:Handle( 'World', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Weather Modulation', 'world_weather' )
    self:GenerateDropdown( nil, 1, 'world_weather_mode', {
        'Rain',
        'Snow',
        'Custom'   
    } )
    self:GenerateMiniCheckbox( nil, 'Allow Indoors', 'world_weather_indoors' )
    self:GenerateMiniCheckbox( nil, 'Use Textureless Check', 'world_weather_textureless' )
    self:GenerateMiniCheckbox( nil, 'Use Advanced Indoors', 'world_weather_per_particle' )
    self:GenerateColorpicker( nil, 'world_weather_color', self.Colors.White )

    self:GenerateLabel( Panel, 'Custom Particle' )
    self:GenerateInput( nil, 'particles/smokey', 'world_weather_mode_custom' )

    self:GenerateLabel( Panel, 'Area' )
    self:GenerateSlider( nil, 'world_weather_area', 1, 2000, 1000, 0 )

    self:GenerateLabel( Panel, 'Height' )
    self:GenerateSlider( nil, 'world_weather_height', 1, 2000, 1000, 0 )

    self:GenerateLabel( Panel, 'Gravity' )
    self:GenerateSlider( nil, 'world_weather_gravity', 1, 500, 250, 0 )

    self:GenerateLabel( Panel, 'Velocity' )
    self:GenerateSlider( nil, 'world_weather_velocity', 1, 50, 25, 0 )

    self:GenerateLabel( Panel, 'Size' )
    self:GenerateSlider( nil, 'world_weather_size', 1, 10, 5, 0 )

    self:GenerateCheckbox( Panel, 'Adjust Particle Roll', 'world_weather_roll' )
    
    self:GenerateLabel( Panel, 'Target' )
    self:GenerateSlider( nil, 'world_weather_roll_target', 0, 10, 5, 0 )

    self:GenerateLabel( Panel, 'Delta' )
    self:GenerateSlider( nil, 'world_weather_roll_delta', 0, 5, 3, 0 )

    self:GenerateCheckbox( Panel, 'Adjust Particle Wind', 'world_weather_wind' )

    self:GenerateLabel( Panel, 'Directional X Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_x', 0, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Timescale X Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_timescale_x', 0, 0.5, 0.2, 2 )

    self:GenerateLabel( Panel, 'Directional Y Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_y', 0, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Timescale Y Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_timescale_y', 0, 0.5, 0.3, 2 )

    self:GenerateLabel( Panel, 'Direction Z Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_z', 0, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Timescale Z Axis' )
    self:GenerateSlider( nil, 'world_weather_wind_timescale_z', 0, 0.5, 0.15, 2 )
    
    self:GenerateCheckbox( Panel, 'Add Wind Turbulence', 'world_weather_wind_turbulence' )
    self:GenerateSlider( nil, 'world_weather_wind_turbulence_scale', 1, 10, 5, 0 )

    self:GenerateCheckbox( Panel, 'Audio Ambience Modulation', 'world_weather_audio' )
    self:GenerateDropdown( nil, 1, 'world_weather_audio_mode', {
        'Rain',
        'Snow',
        'Nature'    
    } )

    self:GenerateLabel( Panel, 'Volume' )
    self:GenerateSlider( nil, 'world_weather_audio_volume', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Pitch' )
    self:GenerateSlider( nil, 'world_weather_audio_pitch', 1, 255, 100, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Sky Modulation', 'world_sky' )
    self:GenerateInput( nil, 'skybox/sky_day03_06', 'world_sky_basic' )

    self:GenerateLabel( Panel, 'Colors' )
    self:GenerateColorpicker( nil, 'world_sky_top', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_sky_bottom', self.Colors.White )
    self:GenerateSlider( nil, 'world_sky_fade_bias', 0, 1, 0.5, 1 )

    self:GenerateLabel( Panel, 'HDR' )
    self:GenerateSlider( nil, 'world_sky_hdr', 0, 1, 1, 1 )

    self:GenerateCheckbox( Panel, 'Star Modulation', 'world_sky_stars' )
    self:GenerateInput( nil, 'skybox/starfield', 'world_sky_stars_texture' )

    self:GenerateLabel( Panel, 'Density' )
    self:GenerateSlider( nil, 'world_sky_stars_density', 1, 4, 2, 0 )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'world_sky_stars_speed', -150, 150, 0, 0, false, '%' )

    self:GenerateLabel( Panel, 'Edge Fade' )
    self:GenerateSlider( nil, 'world_sky_stars_fade', 0, 1, 0.5, 1 )

    self:GenerateLabel( Panel, 'Scale' )
    self:GenerateSlider( nil, 'world_sky_stars_scale', 0, 5, 2.5, 1 )
    
    self:GenerateCheckbox( Panel, 'Sine Star Speed', 'world_sky_stars_speed_sine' )
    self:GenerateSlider( nil, 'world_sky_stars_speed_sine_amount', 0, 100, 0, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Dusk Modulation', 'world_sky_dusk' )
    self:GenerateColorpicker( nil, 'world_sky_dusk_color', self.Colors.Main )
    self:GenerateSlider( nil, 'world_sky_dusk_intensity', 1, 100, 0, 0, false, '%' )
    self:GenerateSlider( nil, 'world_sky_dusk_scale', 0, 1, 0.5, 1 )

    self:GenerateCheckbox( Panel, 'Sun Modulation', 'world_sky_sun' )
    self:GenerateColorpicker( nil, 'world_sky_sun_color', self.Colors.Main )
    self:GenerateSlider( nil, 'world_sky_sun_size', 1, 100, 0, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'World Modulation', 'world_modulation', function( Enabled )
        Coffee.Modulate:UpdateWorld( Enabled, self.Config[ 'world_modulation_color' ] )
    end )
    self:GenerateColorpicker( nil, 'world_modulation_color', self.Colors.Purple, function( Color )
        Coffee.Modulate:UpdateWorld( self.Config[ 'world_modulation' ], Color )
    end )

    self:GenerateCheckbox( Panel, 'World Fullbright', 'world_fullbright' )
    self:GenerateDropdown( nil, 1, 'world_fullbright_mode', {
        'Total',
        'Edged'    
    } )

    self:GenerateCheckbox( Panel, 'World Material Modulation', 'world_material' )
    self:GenerateInput( nil, 'models/shadertest/shader4', 'world_material_material' )

    self:GenerateCheckbox( Panel, 'Fog Modulation', 'world_fog' )
    self:GenerateColorpicker( nil, 'world_fog_color', self.Colors.White )

    self:GenerateLabel( Panel, 'Start' )
    self:GenerateSlider( nil, 'world_fog_start', 1, 10000, 5000, 0 )

    self:GenerateLabel( Panel, 'End' )
    self:GenerateSlider( nil, 'world_fog_end', 1, 10000, 10000, 0 )

    self:GenerateCheckbox( Panel, 'Color Overlay Modulation', 'world_color_overlay' )
    self:GenerateMiniCheckbox( nil, 'Invert Colors', 'world_color_overlay_invert' )

    self:GenerateLabel( Panel, 'Saturation' )
    self:GenerateSlider( nil, 'world_color_overlay_saturation', 1, 4, 2, 1 )

    self:GenerateLabel( Panel, 'Brightness' )
    self:GenerateSlider( nil, 'world_color_overlay_brightness', 0, 255, 128, 0 )

    self:GenerateLabel( Panel, 'Contrast' )
    self:GenerateSlider( nil, 'world_color_overlay_contrast', 1, 4, 2, 1 )

    self:GenerateCheckbox( Panel, 'Multiply Color', 'world_color_overlay_multiply' )
    self:GenerateColorpicker( nil, 'world_color_overlay_multiply_color', self.Colors.Black )

    self:GenerateCheckbox( Panel, 'Add Color', 'world_color_overlay_add' )
    self:GenerateColorpicker( nil, 'world_color_overlay_add_color', self.Colors.Black )

    self:GenerateCheckbox( Panel, 'Material Overlay Modulation', 'world_material_overlay' )
    self:GenerateInput( nil, 'effects/water_warp01', 'world_material_overlay_material' )

    self:GenerateLabel( Panel, 'Refraction' )
    self:GenerateSlider( nil, 'world_material_overlay_refract', -1, 1, 0, 2 )

    self:GenerateCheckbox( Panel, 'Bloom Modulation', 'world_bloom' )
    self:GenerateColorpicker( nil, 'world_bloom_color', self.Colors.White )
    self:GenerateSlider( nil, 'world_bloom_vivid', 1, 10, 5, 2 )

    self:GenerateLabel( Panel, 'Multiply' )
    self:GenerateSlider( nil, 'world_bloom_multiply', 0, 5, 2.5, 2 )

    self:GenerateLabel( Panel, 'Light Level' )
    self:GenerateSlider( nil, 'world_bloom_light', -1, 1, 0, 2 )

    self:GenerateLabel( Panel, 'Pitch Size' )
    self:GenerateSlider( nil, 'world_bloom_size_x', 0, 10, 5, 0 )

    self:GenerateLabel( Panel, 'Yaw Size' )
    self:GenerateSlider( nil, 'world_bloom_size_y', 0, 10, 5, 0 )

    self:GenerateLabel( Panel, 'Passes' )
    self:GenerateSlider( nil, 'world_bloom_passes', 1, 5, 3, 0 )

    self:GenerateCheckbox( Panel, 'Motion Blur Modulation', 'world_motion_blur' )

    self:GenerateLabel( Panel, 'Alpha Increment' )
    self:GenerateSlider( nil, 'world_motion_blur_alpha', 0, 1, 0.5, 2 )

    self:GenerateLabel( Panel, 'Alpha Frames' )
    self:GenerateSlider( nil, 'world_motion_blur_alpha_frames', 0, 1, 0.5, 2 )
    
    self:GenerateLabel( Panel, 'Capture Delay' )
    self:GenerateSlider( nil, 'world_motion_blur_delay', 0, 0.1, 0.05, 2 )

    self:GenerateCheckbox( Panel, 'Sharpen Modulation', 'world_sharpen' )
    self:GenerateMiniCheckbox( nil, 'Exponent', 'world_sharpen_exponent' )

    self:GenerateLabel( Panel, 'Contrast' )
    self:GenerateSlider( nil, 'world_sharpen_contrast', 0, 3, 2, 1 )

    self:GenerateLabel( Panel, 'Distance' )
    self:GenerateSlider( nil, 'world_sharpen_distance', 0, 3, 2, 1 )

    self:GenerateCheckbox( Panel, 'Sobel Modulation', 'world_sobel' )
    self:GenerateSlider( nil, 'world_sobel_threshold', 0, 1, 0.5, 2 )

    self:GenerateCheckbox( Panel, 'Sunbeam Modulation', 'world_sunbeams' )

    self:GenerateLabel( Panel, 'Contrast' )
    self:GenerateSlider( nil, 'world_sunbeams_multiply', 0, 1, 0.5, 2 )

    self:GenerateLabel( Panel, 'Darkness' )
    self:GenerateSlider( nil, 'world_sunbeams_darkness', 0, 0.1, 0.05, 2 )

    self:GenerateLabel( Panel, 'Sun Size' )
    self:GenerateSlider( nil, 'world_sunbeams_size', 0, 1, 0.5, 2 )

    self:GenerateCheckbox( Panel, 'Texturized Modulation', 'world_texturized' )
    self:GenerateInput( nil, 'pp/texturize/rainbow.png', 'world_texturized_material' )

    self:GenerateLabel( Panel, 'Scale' )
    self:GenerateSlider( nil, 'world_texturized_scale', -1, 1, 0, 2 )
    self:GenerateMiniCheckbox( nil, 'Randomized', 'world_texturized_scale_random' )

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

    self:GenerateLabel( Panel, 'Material' )
    self:GenerateDropdown( nil, 1, 'world_beams_material', {
        'Physbeam',
        'Laser',
        'Lightning',
        'Plasma',
        'Smoke',
        'LOL!',
        'Beam'
    } )

    self:GenerateLabel( Panel, 'Time' )
    self:GenerateSlider( nil, 'world_beams_time', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Width' )
    self:GenerateSlider( nil, 'world_beams_width', 1, 6, 3, 0 )

    self:GenerateLabel( Panel, 'Segments' )
    self:GenerateSlider( nil, 'world_beams_segments', 1, 50, 25, 0 )

    self:GenerateLabel( Panel, 'Speed' )
    self:GenerateSlider( nil, 'world_beams_speed', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Twist' )
    self:GenerateSlider( nil, 'world_beams_twist', 1, 100, 50, 0, false, '%' )
    
    self:GenerateLabel( Panel, 'Cone' )
    self:GenerateSlider( nil, 'world_beams_cone', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Amplitude' )
    self:GenerateSlider( nil, 'world_beams_amplitude', 1, 100, 50, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Impact Effect', 'world_effects' )
    self:GenerateMiniCheckbox( nil, 'Strip flags', 'world_effects_no_flags' )

    self:GenerateLabel( Panel, 'Magnitude' )
    self:GenerateSlider( nil, 'world_effects_magnitude', 1, 32, 16 )

    self:GenerateLabel( Panel, 'Radius' )
    self:GenerateSlider( nil, 'world_effects_radius', 0, 1, 0.5, 2 )

    self:GenerateLabel( Panel, 'Scale' )
    self:GenerateSlider( nil, 'world_effects_scale', 1, 20, 10 )

    self:GenerateLabel( Panel, 'Hurt Effect' )
    self:GenerateDropdown( nil, 1, 'world_effects_hurt', {
        'Tesla', 
        'Gibs', 
        'Sparks', 
        'Heavy Sparks', 
        'Explosion',
        'Vortigaunt',
        'Custom'
    } )

    self:GenerateLabel( Panel, 'Custom Hurt Effect' )
    self:GenerateInput( nil, 'balloon_pop', 'world_effects_hurt_custom' )

    self:GenerateLabel( Panel, 'Kill Effect' )
    self:GenerateDropdown( nil, 1, 'world_effects_kill', {
        'Tesla', 
        'Gibs', 
        'Sparks', 
        'Heavy Sparks', 
        'Explosion',
        'Vortigaunt',
        'Custom'
    } )

    self:GenerateLabel( Panel, 'Custom Kill Effect' )
    self:GenerateInput( nil, 'balloon_pop', 'world_effects_kill_custom' )

    self:GenerateCheckbox( Panel, 'Hitsound', 'world_hitsound' )
    self:GenerateInput( nil, 'garrysmod/balloon_pop_cute.wav', 'world_hitsound_sound' )

    self:GenerateLabel( Panel, 'Volume' )
    self:GenerateSlider( nil, 'world_hitsound_volume', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Passes' )
    self:GenerateSlider( nil, 'world_hitsound_passes', 1, 10, 5 )

    self:GenerateCheckbox( Panel, 'Killsound', 'world_killsound' )
    self:GenerateInput( nil, 'garrysmod/balloon_pop_cute.wav', 'world_killsound_sound' )
    
    self:GenerateLabel( Panel, 'Volume' )
    self:GenerateSlider( nil, 'world_killsound_volume', 1, 100, 50, 0, false, '%' )

    self:GenerateLabel( Panel, 'Passes' )
    self:GenerateSlider( nil, 'world_killsound_passes', 1, 10, 5 )

    self:GenerateCheckbox( Panel, 'Hitmarker', 'world_hitmarker' )
    self:GenerateColorpicker( nil, 'world_hitmarker_color', self.Colors.White )
    self:GenerateMiniCheckbox( nil, 'Check 3D Hit', 'world_hitmarker_check_hit' )
    self:GenerateDropdown( nil, 1, 'world_hitmarker_mode', {
        '2D', 
        '3D',
        'Both'
    } )

    self:GenerateCheckbox( Panel, 'Dynamic Fade', 'world_hitmarker_fade' )

    self:GenerateLabel( Panel, 'Time' )
    self:GenerateSlider( nil, 'world_hitmarker_time', 0.1, 5, 2.5, 2 )

    self:GenerateLabel( Panel, 'Space' )
    self:GenerateSlider( nil, 'world_hitmarker_space', 1, 32, 8 )

    self:GenerateLabel( Panel, 'Center Space' )
    self:GenerateSlider( nil, 'world_hitmarker_length', 1, 5, 3 )

    self:GenerateCheckbox( Panel, 'Overlay Hitmarker', 'world_hitmarker_overlay' )
    self:GenerateColorpicker( nil, 'world_hitmarker_overlay_color', self.Colors.Main )
    self:GenerateSlider( nil, 'world_hitmarker_overlay_space', 1, 32, 16 )

    self:GenerateCheckbox( Panel, 'Announcer', 'world_announcer' )
    self:GenerateSlider( nil, 'world_announcer_volume', 1, 100, 50, 0, false, '%' )
    self:GenerateInput( nil, 'announcer/mw2', 'world_announcer_directory' )

    self:GenerateCheckbox( Panel, 'Announce Killstreak', 'world_announcer_killstreak' )
    self:GenerateSlider( nil, 'world_announcer_killstreak_number', 1, 6, 3, 0 )

    self:GenerateCheckbox( Panel, 'Announce Kills', 'world_announcer_kill' )
    self:GenerateSlider( nil, 'world_announcer_kill_chance', 1, 100, 30, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Local Update Visualizer', 'world_update' )
    self:GenerateColorpicker( nil, 'world_update_current_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'world_update_line_color', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Thirdperson', 'world_thirdperson' )
    self:GenerateKeybind( nil, 'world_thirdperson_keybind' )
    self:GenerateSlider( nil, 'world_thirdperson_distance', 1, 250, 125, 0 )

    self:GenerateLabel( Panel, 'Up Modifier' )
    self:GenerateSlider( nil, 'world_thirdperson_distance_up', -250, 250, 0, 0 )

    self:GenerateLabel( Panel, 'Right Modifier' )
    self:GenerateSlider( nil, 'world_thirdperson_distance_right', -250, 250, 0, 0 )

    self:GenerateCheckbox( Panel, 'Camera Collisions', 'world_thirdperson_collisions' )
    
    self:GenerateCheckbox( Panel, 'Camera Interpolation', 'world_thirdperson_interpolation' )

    self:GenerateCheckbox( Panel, 'Viewmodel Adjustments', 'world_viewmodel' )
    self:GenerateMiniCheckbox( nil, 'Override Sway', 'world_viewmodel_sway' )
    self:GenerateMiniCheckbox( nil, 'Override Bob', 'world_viewmodel_bob' )
    self:GenerateMiniCheckbox( nil, 'No Recoil', 'world_viewmodel_recoil' )
    self:GenerateMiniCheckbox( nil, 'Enforce Gamemode View', 'world_viewmodel_gamemode_view' )

    self:GenerateLabel( Panel, 'Sway Scale' )
    self:GenerateSlider( nil, 'world_viewmodel_sway_scale', 0, 200, 100, 0, false, '%' )

    self:GenerateLabel( Panel, 'Bob Scale' )
    self:GenerateSlider( nil, 'world_viewmodel_bob_scale', 0, 200, 100, 0, false, '%' )

    self:GenerateCheckbox( Panel, 'Visualize Aimbot', 'world_viewmodel_visualize_aimbot' )
    
    self:GenerateCheckbox( Panel, 'Override FOV', 'world_fov' )
    self:GenerateSlider( nil, 'world_fov_amount', 0, 150, 75, 0 )

    self:GenerateCheckbox( Panel, 'Override Offsets', 'world_offsets' )
    
    self:GenerateLabel( Panel, 'Base' )
    self:GenerateDropdown( nil, 1, 'world_offsets_base', {
        'Default', 
        'Eye',
        'Floor'
    } )

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

    self:GenerateCheckbox( Panel, 'Adjust Hand Model', 'world_hands' )
    self:GenerateInput( nil, 'models/weapons/c_arms_chell.mdl', 'world_hands_model' )

    self:GenerateCheckbox( Panel, 'Anonymizer', 'world_anonymizer' )

    self:GenerateLabel( Panel, 'Name Length' )
    self:GenerateSlider( nil, 'world_anonymizer_length', 1, 8, 4, 0 )

    self:GenerateButton( Panel, 'Strip Icons', function( )
        Coffee.Anonymizer:Update( )
    end )

    self:GenerateCheckbox( Panel, 'Choke Indicator', 'world_choke_indicator' )

    self:GenerateCheckbox( Panel, 'LC Indicator', 'world_lc_indicator' )
end, true )

-- Items Tab

Coffee.Menu:Handle( 'Items', function( self, Panel )
    self:GenerateCheckbox( Panel, 'Render Items', 'items_render' )
    self:GenerateColorpicker( nil, 'items_render_color', self.Colors.White )
    self:GenerateDropdown( nil, 1, 'items_render_font', {
        'Main',
        'Small'
    }, 50 )
    self:GenerateMiniCheckbox( nil, 'Show Distance', 'items_render_distance' )

    self:GenerateCheckbox( Panel, 'Visualize Dormancy', 'items_visualize_dormant' )
    self:GenerateColorpicker( nil, 'items_visualize_dormant_color', self.Colors.Gray )

    self:GenerateCheckbox( Panel, 'Limit Distance', 'items_limit_distance'  )
    self:GenerateSlider( nil, 'items_limit_distance_distance', 1, 10000, 5000, 0 )

    -- I wanted to make this more dynamic and kinda just made it
    -- really fat. Maybe recode? This can be used in other projects
    -- so I kinda did my job.

    self:GenerateButton( Panel, 'Select', function( self )
        Coffee.Items:Select( true, Coffee.Menu.Items.DCollapsible )
    end )

    self:GenerateButton( Panel, 'Deselect', function( self )
        Coffee.Items:Select( false, Coffee.Menu.Items.DCollapsible )
    end )

    self:GenerateButton( Panel, 'Select All', function( self )
        Coffee.Items:Select( true, Coffee.Menu.Items.DCollapsible, true )
    end )

    self:GenerateButton( Panel, 'Deselect All', function( self )
        Coffee.Items:Select( false, Coffee.Menu.Items.DCollapsible, true )
    end )
end )


Coffee.Menu:Handle( 'Items', function( self, Panel )
    self:GenerateList( Panel, 'Items', function( self )
        Coffee.Items:Update( self )
    end )
end, true )

-- Miscellaneous Tab

Coffee.Menu:Handle( 'Miscellaneous', function( self, Panel )
    self:GenerateLabel( Panel, 'Menu Color' )
    self:GenerateColorpicker( nil, 'miscellaneous_menu', self.Color, function( Color )
        self.Color = Color
    end )
    self:GenerateMiniCheckbox( nil, 'Affect Labels', 'miscellaneous_menu_labels' )

    self:GenerateLabel( Panel, 'Menu Fade Speed' )
    self:GenerateSlider( nil, 'miscellaneous_menu_fade', 0, 0.5, 0.25, 2 )

    self:GenerateCheckbox( Panel, 'Menu Constellation', 'miscellaneous_constellation' )
    self:GenerateColorpicker( nil, 'miscellaneous_constellation_dot_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'miscellaneous_constellation_line_color', self.Colors.Main )

    self:GenerateCheckbox( Panel, 'Constellation Mouse Input', 'miscellaneous_constellation_input' )
    self:GenerateSlider( nil, 'miscellaneous_constellation_input_distance', 150, 200, 175, 0 )
    self:GenerateMiniCheckbox( nil, 'Invert', 'miscellaneous_constellation_input_invert' )

    self:GenerateCheckbox( Panel, 'Equalized Constellation', 'miscellaneous_constellation_equalized' )
    self:GenerateMiniCheckbox( nil, 'Invert', 'miscellaneous_constellation_equalized_invert' )

    self:GenerateCheckbox( Panel, 'Watermark', 'miscellaneous_watermark'  )
    self:GenerateColorpicker( nil, 'miscellaneous_watermark_color', self.Colors.Main )
    self:GenerateColorpicker( nil, 'miscellaneous_watermark_text_color', self.Colors.White )
    self:GenerateColorpicker( nil, 'miscellaneous_watermark_background_color', self.Colors.Invisible )

    self:GenerateCheckbox( Panel, 'Notifications', 'miscellaneous_notifications'  )
    self:GenerateColorpicker( nil, 'miscellaneous_notifications_color', self.Colors.Main )
    self:GenerateMiniCheckbox( nil, 'Outgoing Damage', 'miscellaneous_notifications_outgoing' )
    self:GenerateMiniCheckbox( nil, 'Incoming Damage', 'miscellaneous_notifications_incoming' )
    self:GenerateMiniCheckbox( nil, 'Connections', 'miscellaneous_notifications_join' )
    self:GenerateMiniCheckbox( nil, 'Disconnections', 'miscellaneous_notifications_leave' )

    self:GenerateCheckbox( Panel, 'Console Notifications', 'miscellaneous_notifications_console'  )

    self:GenerateCheckbox( Panel, 'Hint Notifications', 'miscellaneous_notifications_hints'  )
    self:GenerateDropdown( nil, 1, 'miscellaneous_notifications_hints_type', {
        'Generic',
        'Error',
        'Undo',
        'Hint',
        'Cleanup'    
    }, nil, nil, true )
    self:GenerateMiniCheckbox( nil, 'Play Noise', 'miscellaneous_notifications_hints_noise' )

    self:GenerateCheckbox( Panel, 'Spectator List', 'miscellaneous_spectator_list'  )

    self:GenerateCheckbox( Panel, 'Admin List', 'miscellaneous_admin_list'  )
    
    self:GenerateCheckbox( Panel, 'Bunnyhop', 'miscellaneous_bunnyhop'  )

    self:GenerateCheckbox( Panel, 'Autostrafe', 'miscellaneous_autostrafe'  )
    self:GenerateDropdown( nil, 1, 'miscellaneous_autostrafe_style', {
        'Classic',
        'Assistive'
    } )
    self:GenerateMiniCheckbox( nil, 'Unlock Landing', 'miscellaneous_autostrafe_unlock'  )
    self:GenerateMiniCheckbox( nil, 'Clamp Sidemove', 'miscellaneous_autostrafe_clamp'  )
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

    self:GenerateCheckbox( Panel, 'Equipbot', 'miscellaneous_equipbot'  )
    self:GenerateMiniCheckbox( nil, 'Ignore Gamemode', 'miscellaneous_equipbot_ignore_gamemode' )
    self:GenerateMiniCheckbox( nil, 'Auto Select', 'miscellaneous_equipbot_auto_select' )
    self:GenerateInput( nil, nil, 'miscellaneous_equipbot_item' )

    self:GenerateCheckbox( Panel, 'Coverbot', 'miscellaneous_coverbot'  )
    self:GenerateKeybind( nil, 'miscellaneous_coverbot_keybind' )
    self:GenerateInput( nil, 'models/hunter/blocks/cube6x6x6.mdl', 'miscellaneous_coverbot_prop' )

    self:GenerateCheckbox( Panel, 'Spawn Shield', 'miscellaneous_spawnshield'  )
    self:GenerateInput( nil, 'models/hunter/blocks/cube6x6x6.mdl', 'miscellaneous_spawnshield_prop' )
end, true )