extends VBoxContainer

onready var _reset = $ResetPongBall
onready var _settings = $Settings
onready var _main = $MainMenu
onready var _exit = $ExitGame

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
