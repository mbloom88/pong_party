extends KinematicBody2D

onready var _debug = $Debug
onready var _fatigue_label = $Debug/Fatigue
onready var _fatigue_timer_label = $Debug/FatigueTimer
onready var _fatigue_timer = $FatigueTimer

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'move': $States/Move,
	'deactivated': $States/Deactivated,
}

export var difficulties = {
	'easy': 60,
	'normal': 50,
	'hard': 30,
}

var fatigue = 0
var _move_margin = 0

var difficulty = "" setget set_difficulty
var ball_target = null setget set_ball_target

export var debug_mode_enabled = false

################################################################################
# PRIVATE METHODS
################################################################################
func _change_state(state_name):
	_current_state.exit(self)

	var new_state = _states_map[state_name]
	states_stack[0] = new_state

	_current_state = states_stack[0]

	_current_state.enter(self)

################################################################################

func _configure_ai_difficulty() -> void:
	match difficulty:
		'easy':
			_move_margin = difficulties['easy']
		'normal':
			_move_margin = difficulties['normal']
		'hard':
			_move_margin = difficulties['hard']

################################################################################

func _physics_process(delta):
	var state_name = _current_state.update(self, delta)
	if state_name:
		_change_state(state_name)
	
	_fatigue_timer_label.text = str(_fatigue_timer.time_left)

################################################################################

func _ready():
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]
	_change_state('idle')

	toggle_debug_mode()
	
################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	_configure_ai_difficulty()
	reset_fatigue()
	_fatigue_timer.start()
	_change_state('idle')

################################################################################

func deactivate():
	_fatigue_timer.stop()
	_change_state('deactivated')

################################################################################

func reset_fatigue():
	fatigue = _move_margin
	_fatigue_label.text = str(fatigue)

################################################################################

func toggle_debug_mode():
	if debug_mode_enabled:
		for debug in _debug.get_children():
			debug.visible = true
	else:
		for debug in _debug.get_children():
			debug.visible = false

################################################################################
# SETTERS/GETTERS
################################################################################

func set_ball_target(value):
	ball_target = value

################################################################################

func set_difficulty(value):
	difficulty = value

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_FatigueTimer_timeout():
	fatigue += 1
	_fatigue_label.text = str(fatigue)
