extends GridContainer

signal difficulty_selected(difficulty)

onready var _easy = $Easy
onready var _normal = $Normal
onready var _hard = $Hard

################################################################################
# PRIVATE METHODS
################################################################################

func _determine_pulse(pulsing_button):
	for button in get_children():
		button.idle()
	
	pulsing_button.pulse()

################################################################################
# PUBLIC METHODS
################################################################################

func disable_buttons():
	for button in get_children():
		button.disabled = true
		button.idle()

################################################################################

func enable_buttons():
	for button in get_children():
		button.disabled = false

###############################################################################
# SIGNAL HANDLING
################################################################################

func _on_Easy_pressed():
	_determine_pulse(_easy)
	emit_signal("difficulty_selected", 'easy')

################################################################################

func _on_Normal_pressed():
	_determine_pulse(_normal)
	emit_signal("difficulty_selected", 'normal')

################################################################################

func _on_Hard_pressed():
	_determine_pulse(_hard)
	emit_signal("difficulty_selected", 'hard')
