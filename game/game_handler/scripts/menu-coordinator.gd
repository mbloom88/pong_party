extends Node

signal level_selected(level, players, difficulty)
signal menu_exited(menu)
signal play_bgm(song)
signal rematch
signal remove_current_level
signal reset_pong_ball_requested

export var level_selection = ""
export var main = ""
export var pause = ""
export var settings = ""
export var splash = ""
export var victory = ""

################################################################################
# PUBLIC METHODS
################################################################################

func load_menu(menu):
	var new_menu = null
	
	match menu:
		'level_selection':
			new_menu = load(level_selection).instance()
		'main':
			new_menu = load(main).instance()
		'pause':
			new_menu = load(pause).instance()
		'settings':
			new_menu = load(settings).instance()
		'splash':
			new_menu = load(splash).instance()
		'victory':
			new_menu = load(victory).instance()
	
	add_child(new_menu)
	new_menu.connect("add_menu", self, "_on_Menu_add_menu")
	new_menu.connect("state_changed", self, "_on_Menu_state_changed")
	
	if new_menu.filename == level_selection:
		new_menu.connect(
			"level_selected",
			self,
			"_on_LevelSelection_level_selected")
	elif new_menu.filename == pause:
		new_menu.connect(
			"reset_pong_ball_requested",
			self,
			"_on_Pause_reset_pong_ball_requested")
	
	new_menu.activate()
	
	if new_menu.bgm:
		emit_signal("play_bgm", new_menu.bgm)

################################################################################

func intro() -> void:
	load_menu('splash')

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_LevelSelection_level_selected(selections):
	for menu in get_children():
		menu.queue_free()
	
	emit_signal("level_selected", selections)

################################################################################

func _on_Menu_add_menu(menu):
	load_menu(menu)

################################################################################

func _on_Menu_state_changed(menu, menu_states):
	if menu_states[0].name.to_lower() == 'exit':
		
		if get_child_count() > 1:
			get_child(get_child_count() - 2).resume_processing()
		
		if menu.filename == splash:
			load_menu('main')
		elif menu.filename in [pause, victory] and menu.decision:
			if menu.decision == 'main':
				load_menu('main')
				emit_signal("remove_current_level")
			elif menu.decision == 'rematch':
				emit_signal("rematch")
		
		menu.queue_free()
	
		emit_signal("menu_exited", menu.name)

################################################################################

func _on_Pause_reset_pong_ball_requested():
	emit_signal("reset_pong_ball_requested")
