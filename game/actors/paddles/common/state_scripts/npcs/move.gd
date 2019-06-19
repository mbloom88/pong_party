extends "res://actors/common/state_scripts/state.gd"

export var move_speed = 1500

################################################################################
# PUBLIC METHODS
################################################################################

func update(host, delta):
	var direction = Vector2()
	var action = ''

	if host.position.distance_to(host.ball_target.position) > \
		Utils.display_width() * 0.75:
		action = 'idle'
	else:
		if host.ball_target.position.y > (host.position.y + host.fatigue):
			direction = Vector2(0, 1)
		elif host.ball_target.position.y < (host.position.y - host.fatigue):
			direction = Vector2(0, -1)
	
	if direction:
		var velocity: Vector2 = direction * move_speed * delta
		host.move_and_collide(velocity)
	
	return action
