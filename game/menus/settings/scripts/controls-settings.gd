extends NinePatchRect

onready var _scroll = $ScrollContainer

export var max_scroll = 0

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Key_scroll_window(action):
	var count = 1.0
	var total = 0.0
	
	for setting in SettingsMaster.settings['controls']:
		total += 1.0
	
	for setting in SettingsMaster.settings['controls']:
		if action == setting:
			if count == 1.0:
				_scroll.scroll_vertical = 0
			else:
				_scroll.scroll_vertical = int((count/total) * max_scroll)
			print("%s / 81" % _scroll.scroll_vertical)
		else:
			count += 1.0
