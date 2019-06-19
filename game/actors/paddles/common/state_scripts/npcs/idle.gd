extends "res://actors/common/state_scripts/state.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func update(host, delta):
	var direction = Vector2()
	var action = ''

	if host.position.distance_to(host.ball_target.position) < \
		Utils.display_width() * 0.75:

		action = 'move'
	
	return action
