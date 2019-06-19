extends KinematicBody2D

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'move': $States/Move,
	'deactivated': $States/Deactivated,
}

var player_number: int = 1 setget set_player_number

################################################################################
# PRIVATE METHODS
################################################################################
func _change_state(state_name) -> void:
	_current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
	else:
		var new_state = _states_map[state_name]
		states_stack[0] = new_state

	_current_state = states_stack[0]

	if state_name != 'previous':
		_current_state.enter(self)


func _physics_process(delta):
	var state_name = _current_state.update(self, delta)
	if state_name:
		_change_state(state_name)


func _ready():
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]
	_change_state('idle')

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	_change_state('idle')

################################################################################

func deactivate():
	_change_state('deactivated')

################################################################################
# SETTERS/GETTERS
################################################################################
func set_player_number(value):
	player_number = value
