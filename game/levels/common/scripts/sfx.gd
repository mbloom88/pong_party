extends AudioStreamPlayer

export (String) var _goal_sound = "" 

################################################################################
# PUBLIC METHODS
################################################################################
func play_goal() -> void:
	stream = load(_goal_sound)
	play()

