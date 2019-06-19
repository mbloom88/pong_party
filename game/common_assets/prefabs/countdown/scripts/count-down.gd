extends Control

onready var _animation = $AnimationPlayer

################################################################################
# PUBLIC METHODS
################################################################################

func countdown():
	visible = true
	_animation.play("countdown")

################################################################################

func stop():
	_animation.stop()
	visible = false

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().call_group("npcs", "activate")
	get_tree().call_group("balls", "activate")
	visible = false
