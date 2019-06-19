extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.main_buttons.get_child(0).grab_focus()
	host.animation.play("slide-in")
	yield(host.animation, "animation_finished")
	
	get_tree().call_group('settings_buttons', 'enable')
	host.main_buttons.activate()
	
	host.emit_signal('state_changed', host, host.states_stack)

################################################################################

func handle_input(host, event):
	if Input.is_action_just_pressed("ui_cancel"):
		return 'exit'

################################################################################

func exit(host):
	get_tree().call_group('settings_buttons', 'disable')
