extends Node

onready var _bgm = $BGM
onready var _level = $LevelCoordinator
onready var _menu = $MenuCoordinator
onready var _pause_timer = $PauseTimer

var pause_enabled = true

################################################################################
# PRIVATE METHODS
################################################################################

func _process(delta):
		if Input.is_action_just_pressed("ui_cancel") and \
			_level.get_child_count() > 0 and pause_enabled:
			
			pause_enabled = false
			get_tree().paused = true
			_menu.load_menu('pause')

################################################################################

func _ready() -> void:
	_menu.intro()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_LevelCoordinator_rematch():
	_pause_timer.start()

################################################################################

func _on_LevelCoordinator_request_victory_menu():
	_menu.load_menu('victory')

################################################################################

func _on_LevelCoordinator_victory_achieved():
	pause_enabled = false

################################################################################

func _on_MenuCoordinator_level_selected(selections):
	pause_enabled = true
	_bgm.stop_music()
	_level.load_level(selections)

################################################################################

func _on_MenuCoordinator_menu_exited(menu):
	if menu.to_lower() == 'pause':
		get_tree().paused = false
		_pause_timer.start()

################################################################################

func _on_MenuCoordinator_rematch():
	_level.rematch()

################################################################################

func _on_MenuCoordinator_remove_current_level():
	_level.remove_level()

################################################################################

func _on_MenuCoordinator_reset_pong_ball_requested():
	_level.reset_pong_ball()
	get_tree().paused = false

################################################################################

func _on_PauseTimer_timeout():
	pause_enabled = true

################################################################################

func _on_play_bgm(song):
	_bgm.stop_music()
	_bgm.load_music(song)
	_bgm.play_music()
