extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	get_tree().call_group('buttons', 'disable_buttons')
	host.emit_signal('state_changed', host, host.states_stack)
