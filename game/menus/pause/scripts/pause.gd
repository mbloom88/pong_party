extends Control

signal add_menu(menu)
signal reset_pong_ball_requested
signal state_changed(menu, states_stack)

onready var animation = $AnimationPlayer
onready var menu_buttons = $BackPanel/MenuButtons
onready  var _settings = $BackPanel/MenuButtons/Settings

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

var decision = ""

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

func _input(event):
	var state_name = _current_state.handle_input(self, event)
	if state_name:
		_change_state(state_name)

################################################################################

func _ready():
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]
	_change_state('idle')

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	_change_state('process')

################################################################################

func resume_processing() -> void:
	_change_state('previous')

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_ExitGame_pressed():
	get_tree().quit()

################################################################################

func _on_MainMenu_pressed():
	decision = 'main'
	_change_state('exit')

################################################################################

func _on_ResetPongBall_pressed():
	emit_signal("reset_pong_ball_requested")
	_change_state('exit')

################################################################################

func _on_Resume_pressed():
	_change_state('exit')

################################################################################

func _on_Settings_pressed():
	current_button_focus = _settings
	emit_signal("add_menu", 'settings')
	_change_state('paused')
