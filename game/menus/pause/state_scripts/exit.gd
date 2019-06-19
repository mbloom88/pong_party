extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.animation.play("slide-out")
	yield(host.animation, "animation_finished")
	host.emit_signal('state_changed', host, host.states_stack)
