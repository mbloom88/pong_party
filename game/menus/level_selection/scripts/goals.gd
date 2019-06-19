extends HBoxContainer

signal goal_selected(goal)

onready var _goal_number = $GoalNumber
onready var _set = $Set

onready var _selected_goal_value = $GoalNumber.min_value

################################################################################
# PUBLIC METHODS
################################################################################

func disable_buttons():
	_set.disabled = true

################################################################################

func enable_buttons():
	_set.disabled = false

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_GoalNumber_value_changed(value):
	_selected_goal_value = int(value)

################################################################################

func _on_Less_pressed():
	_goal_number.value -= 1

################################################################################

func _on_More_pressed():
	_goal_number.value += 1

################################################################################

func _on_Set_pressed():
	emit_signal("goal_selected", _selected_goal_value)
