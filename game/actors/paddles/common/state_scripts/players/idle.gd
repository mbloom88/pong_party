extends "res://actors/paddles/common/state_scripts/players/motion.gd"

################################################################################
# PUBLIC METHODS
################################################################################

func update(host, delta):
	var direction = _detect_movement(host.player_number)
	var action = ''
	
	if direction:
		action = 'move'
	
	return action
