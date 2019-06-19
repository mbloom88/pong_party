extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.transition.fade("out", 1.0)
	yield(host.transition, "fade_completed")
	host.emit_signal('state_changed', host, host.states_stack)
