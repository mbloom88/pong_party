extends Control

const COLOR_WHITE = Color(1, 1, 1, 1)
const LINE_WIDTH = 10.0

################################################################################
# PRIVATE METHODS
################################################################################
func _draw() -> void:
	var start_point = Vector2(Utils.display_width() / 2, 0)
	var end_point = Vector2(Utils.display_width() / 2, 25)

	while end_point.y <= Utils.display_height() + 100:
		draw_line(start_point, end_point, COLOR_WHITE, LINE_WIDTH)
		start_point.y += 50
		end_point.y += 50
