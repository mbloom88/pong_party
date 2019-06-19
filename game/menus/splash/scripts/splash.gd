extends Control

signal add_menu(menu)
signal state_changed(menu, states_stack)

onready var animation = $AnimationPlayer
onready var godot = $GodotContainer
onready var company = $CompanyContainer

var _current_state: Object = null
var states_stack: Array = []

onready var _states_map: Dictionary = {
	'idle': $States/Idle,
	'process': $States/Process,
	'exit': $States/Exit,
}

export (String) var bgm = ""

################################################################################
# PRIVATE METHODS
################################################################################
func _change_state(state_name: String) -> void:
	_current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
	else:
		var new_state = _states_map[state_name]
		states_stack[0] = new_state

	_current_state = states_stack[0]

	if state_name != 'previous':
		_current_state.enter(self)


func _input(event: InputEvent) -> void:
	var state_name: String = _current_state.handle_input(self, event)
	if state_name:
		_change_state(state_name)


func _ready() -> void:
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]

################################################################################
# PUBLIC METHODS
################################################################################
func activate() -> void:
	_change_state('process')

################################################################################
# SIGNAL HANDLING METHODS
################################################################################
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	_change_state('exit')
