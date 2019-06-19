extends GridContainer

signal level_selected(level)
signal video_selected(level, video)

onready var _classic = $Classic

export var classic_level = ""
export var classic_level_video = ""

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

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Classic_pressed():
	_determine_pulse(_classic)
	emit_signal("level_selected", classic_level)

################################################################################

func _on_Classic_focus_entered():
	emit_signal("video_selected", _classic.name, classic_level_video)
