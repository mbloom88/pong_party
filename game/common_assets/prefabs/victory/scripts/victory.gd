extends Control

signal animations_completed

onready var _animation = $AnimationPlayer
onready var _player = $CenterContainer2/Player

var victorious_player = "" setget set_victorious_player

################################################################################
# PUBIC METHODS
################################################################################

func show_victory():
	visible = true
	_animation.play('victory')

################################################################################
# SETTERS/GETTERS
################################################################################

func set_victorious_player(value):
	victorious_player = value
	
	_player.text = "Player {}".format([victorious_player], "{}")

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'victory':
		_animation.play("fade-out")
	elif anim_name == 'fade-out':
		emit_signal("animations_completed")
