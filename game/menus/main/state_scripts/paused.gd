extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	for button in host.main_buttons.get_children():
		button.disabled = true
	
	host.emit_signal('state_changed', host, host.states_stack)

################################################################################

func exit(host):
	for button in host.main_buttons.get_children():
		button.disabled = false
	
	host.current_button_focus.grab_focus()
