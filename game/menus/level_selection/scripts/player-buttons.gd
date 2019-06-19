extends GridContainer

signal players_selected(players)

onready var _one = $OnePlayer
onready var _two = $TwoPlayers

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

func _on_OnePlayer_pressed():
	_determine_pulse(_one)
	emit_signal("players_selected", 1)

################################################################################

func _on_TwoPlayers_pressed():
	_determine_pulse(_two)
	emit_signal("players_selected", 2)
