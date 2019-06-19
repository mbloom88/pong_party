extends Node


func display_height() -> int:
	return ProjectSettings.get_setting("display/window/size/height")


func display_width() -> int:
	return ProjectSettings.get_setting("display/window/size/width")


func get_game_version() -> String:
	return ProjectSettings.get_setting("application/config/game_version")
