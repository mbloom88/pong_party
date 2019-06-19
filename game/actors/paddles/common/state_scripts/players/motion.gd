extends "res://actors/common/state_scripts/state.gd"

################################################################################
# PRIVATE METHODS
################################################################################
func _detect_movement(player_number: int) -> Vector2:
	var direction: = Vector2()
	
	match player_number:
		1:
			direction.y = int(Input.is_action_pressed("player1_move_down")) - \
				int(Input.is_action_pressed("player1_move_up"))
		2:
			direction.y = int(Input.is_action_pressed("player2_move_down")) - \
				int(Input.is_action_pressed("player2_move_up"))
	
	return direction
