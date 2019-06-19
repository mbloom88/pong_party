extends "res://menus/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.level_buttons.get_child(0).grab_focus()
	host.animation.play("slide-in")
	yield(host.animation, "animation_finished")
	get_tree().call_group('buttons', 'enable_buttons')
	host.start_game.disabled = true
	host.emit_signal('state_changed', host, host.states_stack)

################################################################################

func exit(host):
	get_tree().call_group('buttons', 'disable_buttons')

################################################################################

func handle_input(host, event):
	if Input.is_action_just_pressed("ui_cancel"):
		return 'exit'

################################################################################

func update(host, delta):
	if host.selections['players'] == 1:
		host.difficulty_buttons.enable_buttons()
		
		if host.selections['level'] != "" and \
			host.selections['difficulty'] != "":
			
			host.start_game.disabled = false
			host.start_game.pulse()
		else:
			host.start_game.disabled = true
			host.start_game.idle()

	elif host.selections['players'] == 2:
		host.selections['difficulty'] = ""
		host.difficulty_buttons.disable_buttons()
		
		if host.selections['level'] != "":
			host.start_game.disabled = false
			host.start_game.pulse()
		else:
			host.start.disabled = true
			host.start_game.idle()
	else:
		host.start_game.disabled = true
		host.start_game.idle()
