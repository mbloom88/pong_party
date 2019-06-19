extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	get_tree().call_group('settings_buttons', 'disable')

	host.hide_secondary_panels()
	host.secondary_panels.get_child(0).visible = true
	
	host.keybind_popup.visible = false
	
	host.emit_signal('state_changed', host, host.states_stack)
