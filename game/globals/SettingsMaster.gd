extends Node

const SAVE_PATH = "user://settings.ini"

var _default_settings = {
	'sound': {
		'master_volume': 0,
	},
	'video': {
		'display_resolution': Vector2(1280, 720),
		'fullscreen_mode': false,
		'borderless_window': false,
	},
	'controls': {
		'player1_move_up': KEY_W,
		'player1_move_down': KEY_S,
		'player2_move_up': KEY_KP_8,
		'player2_move_down': KEY_KP_5,
		'ui_accept': KEY_SPACE,
		'ui_cancel': KEY_ESCAPE,
		
	},
}

var settings = {
	'sound': {
		'master_volume': 0,
	},
	'video': {
		'display_resolution': Vector2(1280, 720),
		'fullscreen_mode': false,
		'borderless_window': false,
	},
	'controls': {
		'player1_move_up': KEY_W,
		'player1_move_down': KEY_S,
		'player2_move_up': KEY_KP_8,
		'player2_move_down': KEY_KP_5,
		'ui_accept': KEY_SPACE,
		'ui_cancel': KEY_ESCAPE,
	},
}

################################################################################
# PRIVATE METHODS
################################################################################

func _configure_new_keybind(action, event):
	var event_list = InputMap.get_action_list(action)
	
	for event in event_list:
		if event is InputEventKey:
			InputMap.action_erase_event(action, event)
	
	var new_event = InputEventKey.new()
	new_event.scancode = event
	InputMap.action_add_event(action, new_event)

################################################################################

func _initialize_settings():
	set_borderless_window(settings['video']['borderless_window'])
	set_display_resolution(settings['video']['display_resolution'])
	set_fullscreen_mode(settings['video']['fullscreen_mode'])
	set_master_volume(settings['sound']['master_volume'])
	
	for key in settings['controls'].keys():
		set_controls_action(key, settings['controls'][key])

	get_tree().call_group("settings", "update_setting")
	
################################################################################

func _load_settings():
	var ini_file = ConfigFile.new()
	var error = ini_file.load(SAVE_PATH)
	
	if error != OK: # if no INI file exists
		settings = _default_settings
		save_settings()
	else:
		for section in settings.keys():
			for key in settings[section]:
				settings[section][key] = ini_file.get_value(section, key, null)
	
	_initialize_settings()

################################################################################

func _ready():
	_load_settings()

################################################################################
# PUBLIC METHODS
################################################################################

func load_default_settings():
	for section in _default_settings.keys():
		for key in _default_settings[section]:
			settings[section][key] = _default_settings[section][key]

	_initialize_settings()

################################################################################

func save_settings():
	var ini_file = ConfigFile.new()
	
	for section in settings.keys():
		for key in settings[section]:
			ini_file.set_value(section, key, settings[section][key])

	ini_file.save(SAVE_PATH)

################################################################################
# SETTERS/GETTERS
################################################################################

func get_borderless_window():
	return settings['video']['borderless_window']

################################################################################

func get_controls_action(action):
	return settings['controls'][action]

################################################################################

func get_display_resolution():
	return settings['video']['display_resolution']

################################################################################

func get_fullscreen_mode():
	return settings['video']['fullscreen_mode']

################################################################################

func get_master_volume():
	return settings['sound']['master_volume']

################################################################################

func set_borderless_window(value):
	settings['video']['borderless_window'] = value # bool
	
	OS.set_borderless_window(value)

################################################################################

func set_controls_action(action, value):
	settings['controls'][action] = value # int enum KeyList
	_configure_new_keybind(action, value)

################################################################################

func set_display_resolution(value):
	settings['video']['display_resolution'] = value # Vector2
	
	OS.set_window_size(value)

################################################################################

func set_fullscreen_mode(value):
	settings['video']['fullscreen_mode'] = value # bool
	
	OS.window_fullscreen = value

################################################################################

func set_master_volume(value):
	settings['sound']['master_volume'] = value # int decibels
	
	if value != -20:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, value)
	else:
		AudioServer.set_bus_mute(0, true)
