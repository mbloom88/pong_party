extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.transition.color = Color.cornflower
	host.version.text = "Version %s" % Utils.get_game_version()
	host.version.visible = false
	host.main_buttons.visible = false
	host.emit_signal('state_changed', host, host.states_stack)
