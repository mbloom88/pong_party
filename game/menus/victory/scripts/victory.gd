extends Control

signal add_menu(menu)
signal state_changed(menu, states_stack)

onready var animation = $AnimationPlayer
onready var menu_buttons = $BackPanel/MenuButtons

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'process': $States/Process,
	'exit': $States/Exit,
}

export var bgm = ""

var decision = ""

################################################################################
# PRIVATE METHODS
################################################################################

func _change_state(state_name):
	_current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
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

func activate():
	_change_state('process')

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

func _on_Rematch_pressed():
	decision = 'rematch'
	_change_state('exit')
