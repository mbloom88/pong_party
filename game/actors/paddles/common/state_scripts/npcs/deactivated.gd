extends "res://actors/common/state_scripts/state.gd"

################################################################################
# PRIVATE METHODS
################################################################################

func enter(host):
	host.set_physics_process(false)

################################################################################

func exit(host):
	host.set_physics_process(true)
