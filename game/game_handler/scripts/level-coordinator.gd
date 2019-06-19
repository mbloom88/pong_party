extends Node

signal play_bgm(song)
signal rematch
signal request_victory_menu
signal victory_achieved

################################################################################
# PUBLIC METHODS
################################################################################
func load_level(selections):
	remove_level()
	
	var new_level = load(selections['level']).instance()
	add_child(new_level)
	
	new_level.connect(
		"victory_achieved",
		self,
		"_on_Level_victory_achieved")
	new_level.connect(
		"request_victory_menu",
		self,
		"_on_Level_request_victory_menu")
	
	new_level.ai_difficulty = selections['difficulty']
	new_level.goal_victory = selections['goals']
	new_level.number_of_players = selections['players']
	
	if new_level.bgm:
		emit_signal("play_bgm", new_level.bgm)
	
	new_level.activate()
	
################################################################################

func rematch():
	get_child(0).rematch()
	emit_signal("play_bgm", get_child(0).bgm)
	emit_signal("rematch")

################################################################################

func remove_level():
	if get_child_count() != 0:
		get_child(0).queue_free()

################################################################################

func reset_pong_ball():
	get_child(0).reset_field()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Level_request_victory_menu():
	emit_signal("request_victory_menu")

################################################################################

func _on_Level_victory_achieved(music):
	emit_signal("play_bgm", music)
	emit_signal("victory_achieved")
