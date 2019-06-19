extends ColorRect

signal fade_completed

onready var _tween = $Tween

################################################################################
# PUBLIC METHODS
################################################################################

func configure_screen_color(value):
	color = value

################################################################################

func fade(type, time):
	var start_alpha = Color(0, 0, 0, 0)
	var finish_alpha = Color(0, 0, 0, 0)

	match type:
		"in":
			start_alpha = Color(1, 1, 1, 0)
			finish_alpha = Color(1, 1, 1, 1)
		"out":
			start_alpha = Color(1, 1, 1, 1)
			finish_alpha = Color(1, 1, 1, 0)
	
	_tween.interpolate_property(
	self,
	"modulate",
	start_alpha,
	finish_alpha,
	time,
	Tween.TRANS_LINEAR, 
	Tween.EASE_IN)
	
	_tween.start()
	yield(_tween, "tween_completed")
	emit_signal("fade_completed")
