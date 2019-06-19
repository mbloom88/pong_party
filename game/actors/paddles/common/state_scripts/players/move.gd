extends "res://actors/paddles/common/state_scripts/players/motion.gd"

export var move_speed = 1500

################################################################################
# PUBLIC METHODS
################################################################################

func update(host, delta):
	var direction = _detect_movement(host.player_number)
	var velocity = direction * move_speed * delta
	var action = ''
	
	if direction:
		host.move_and_collide(velocity)
	else:
		action = 'idle'
	
	return action
