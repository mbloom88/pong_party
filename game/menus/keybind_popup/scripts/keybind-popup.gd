extends NinePatchRect

signal new_keybind(action, event)

var _current_action = null

################################################################################
# PRIVATE METHOD
################################################################################

func _ready():
	disable()

################################################################################

func _input(event):
	if event is InputEventKey:
		emit_signal("new_keybind", _current_action, event)
		disable()

################################################################################
# PUBLIC METHOD
################################################################################

func disable():
	visible = false
	set_process_input(false)

################################################################################

func enable(action):
	_current_action = action
	visible = true
	set_process_input(true)
