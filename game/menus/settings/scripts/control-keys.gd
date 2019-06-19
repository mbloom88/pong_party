extends Button

signal scroll_window(action)
signal request_keybind_popup(action)

export var action = ""

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
	enabled_focus_mode = Control.FOCUS_NONE
	focus_mode = Control.FOCUS_NONE

################################################################################

func enable():
	disabled = false
	enabled_focus_mode = Control.FOCUS_ALL
	focus_mode = Control.FOCUS_ALL

################################################################################

func update_setting():
	var key = InputEventKey.new()
	
	key.scancode = SettingsMaster.get_controls_action(action)
	text = str(key.as_text())

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Key_focus_entered():
		emit_signal("scroll_window", action)

################################################################################

func _on_Key_pressed():
	emit_signal("request_keybind_popup", action)
