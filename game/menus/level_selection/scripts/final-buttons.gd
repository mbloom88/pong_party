extends HBoxContainer

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
