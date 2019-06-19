extends Control

signal add_menu(menu)
signal state_changed(menu, states_stack)

onready var _button_play_game = $MainButtonContainer/PlayGame
onready var _button_settings = $MainButtonContainer/Settings
onready var main_buttons = $MainButtonContainer
onready var transition = $TransitionScreen
onready var version = $Version

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'process': $States/Process,
	'paused': $States/Paused,
	'exit': $States/Exit,
}

export var bgm = ""

var current_button_focus = null

################################################################################
# PRIVATE METHODS
################################################################################

func _change_state(state_name):
	_current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in ['paused']:
		states_stack.push_front(_states_map[state_name])
	else:
		var new_state = _states_map[state_name]
		states_stack[0] = new_state

	_current_state = states_stack[0]

	if state_name != 'previous':
		_current_state.enter(self)

################################################################################

func _ready():
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]
	_change_state('idle')

################################################################################
# PUBLIC METHODS
################################################################################

func activate() -> void:
	_change_state('process')

################################################################################

func resume_processing() -> void:
	_change_state('previous')

################################################################################
# SIGNAL HANDLING METHODS
################################################################################

func _on_ExitGame_pressed() -> void:
	get_tree().quit()

################################################################################

func _on_PlayGame_pressed():
	current_button_focus = _button_play_game
	emit_signal("add_menu", 'level_selection')
	_change_state('paused')

################################################################################

func _on_Settings_pressed() -> void:
	current_button_focus = _button_settings
	emit_signal("add_menu", 'settings')
	_change_state('paused')
