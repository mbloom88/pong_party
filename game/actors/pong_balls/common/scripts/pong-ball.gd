extends KinematicBody2D

onready var sfx = $SFX

var _current_state: Object = null
var states_stack: Array = []

onready var _states_map: Dictionary = {
	'initialize': $States/Initialize,
	'move': $States/Move,
}

var velocity: = Vector2() setget , get_velocity

################################################################################
# PRIVATE METHODS
################################################################################
func _change_state(state_name: String) -> void:
	_current_state.exit(self)

	var new_state = _states_map[state_name]
	states_stack[0] = new_state

	_current_state = states_stack[0]

	_current_state.enter(self)


func _physics_process(delta: float) -> void:
	var state_name: String = _current_state.update(self, delta)
	if state_name:
		_change_state(state_name)


func _ready() -> void:
	set_physics_process(false)
	states_stack.push_front($States/Initialize)
	_current_state = states_stack[0]
	_change_state('initialize')

################################################################################
# PUBLIC METHODS
################################################################################
func activate() -> void:
	_change_state('move')

################################################################################
# SETTERS/GETTERS
################################################################################
func get_velocity() -> Vector2:
	return velocity
