extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.menu_buttons.get_child(0).grab_focus()
	host.animation.play("slide-in")
	yield(host.animation, "animation_finished")
	host.menu_buttons.enable_buttons()

	host.emit_signal('state_changed', host, host.states_stack)

################################################################################

func exit(host):
	host.menu_buttons.disable_buttons()

################################################################################

func handle_input(host, event):
	if Input.is_action_just_pressed("ui_cancel"):
		return 'exit'
