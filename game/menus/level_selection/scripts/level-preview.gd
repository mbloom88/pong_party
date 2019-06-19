extends VideoPlayer

var _current_video = ""

################################################################################
# PUBLIC METHODS
################################################################################

func play_video(video):
	_current_video = video
	stream = load(_current_video)
	play()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_LevelPreview_finished():
	play_video(_current_video)
