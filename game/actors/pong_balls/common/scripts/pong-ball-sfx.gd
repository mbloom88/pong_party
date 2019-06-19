extends AudioStreamPlayer

export (String) var _bounce_sound = "" 

################################################################################
# PUBLIC METHODS
################################################################################
func _play_bounce() -> void:
	stream = load(_bounce_sound)
	play()
