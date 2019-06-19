extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################
func enter(host):
	host.animation.play("splash-sequence")
	host.emit_signal('state_changed', host, host.states_stack)


func handle_input(host, event):
	if event is InputEventMouseButton or event is InputEventKey:
		return 'exit'
