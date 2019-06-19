extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.transition.fade("out", 1.0)
	yield(host.transition, "fade_completed")
	host.main_buttons.visible = true
	host.version.visible = true
	host.main_buttons.get_child(0).grab_focus()
	host.emit_signal('state_changed', host, host.states_stack)
