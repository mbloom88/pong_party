extends OptionButton

################################################################################
# PRIVATE METHODS
################################################################################

func _ready():
	update_setting()

################################################################################
# PUBLIC METHODS
################################################################################

func disable():
	disabled = true

################################################################################

func enable():
	disabled = false

################################################################################

func update_setting():
	var value = SettingsMaster.get_display_resolution()
	
	match value:
		Vector2(1280, 720):
			selected = 0
		Vector2(1920, 1080):
			selected = 1
		Vector2(2560, 1440):
			selected = 2

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_OptionButton_item_selected(ID):
	var size = Vector2()

	match ID:
		0:
			size = Vector2(1280, 720)
		1:
			size = Vector2(1920, 1080)
		2:
			size = Vector2(2560, 1440)
	
	SettingsMaster.set_display_resolution(size)
