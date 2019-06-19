extends "res://levels/common/scripts/level.gd"

onready var _goal1 = $Goals/Goal1
onready var _goal2 = $Goals/Goal2

################################################################################
# PRIVATE METHODS
################################################################################

func _check_for_victory():
	if _score1.text == str(goal_victory):
		emit_signal("victory_achieved", victory_music)
		get_tree().call_group("paddles", "deactivate")
		_remove_pong_ball()
		_victory.victorious_player = '1'
		_victory.show_victory()
	elif _score2.text == str(goal_victory):
		emit_signal("victory_achieved", victory_music)
		get_tree().call_group("paddles", "deactivate")
		_remove_pong_ball()
		_victory.victorious_player = '2'
		_victory.show_victory()
	else:
		call_deferred("_initialize")

################################################################################

func _reset_npcs():
	get_tree().call_group("npcs", "deactivate")
	get_tree().call_group("npcs", "reset_fatigue")

################################################################################
# SIGNAL HANDLING
################################################################################
func _on_Goal1_body_entered(body):
	if body.is_physics_processing():
		_sfx.play_goal()
		_score2.increment_score()
		_reset_npcs()
		_check_for_victory()

################################################################################

func _on_Goal2_body_entered(body):
	if body.is_physics_processing():
		_sfx.play_goal()
		_score1.increment_score()
		_reset_npcs()
		_check_for_victory()
