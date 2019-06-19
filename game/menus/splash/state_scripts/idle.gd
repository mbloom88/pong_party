extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################
func enter(host):
	host.emit_signal('state_changed', host, host.states_stack)
