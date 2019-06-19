extends VBoxContainer

onready var _controls = $Controls
onready var _display = $Display
onready var _sound = $Sound

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

func activate():
	_determine_pulse(_sound)

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Controls_pressed() -> void:
	_determine_pulse(_controls)

################################################################################

func _on_Display_pressed() -> void:
	_determine_pulse(_display)

################################################################################

func _on_Sound_pressed() -> void:
	_determine_pulse(_sound)
