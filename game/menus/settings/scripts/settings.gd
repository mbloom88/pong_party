 extends Control

onready var animation = $AnimationPlayer
onready var keybind_popup = $KeybindPopup
onready var main_buttons = $NinePatchRect/MainButtonPanel/MainButtons
onready var secondary_panels = $NinePatchRect/SecondaryPanels
onready var _sound = $NinePatchRect/SecondaryPanels/SoundSettings
onready var _display = $NinePatchRect/SecondaryPanels/DisplaySettings
onready var _controls = $NinePatchRect/SecondaryPanels/ControlsSettings

signal add_menu(menu)
signal state_changed(menu, states_stack)

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'process': $States/Process,
	'exit': $States/Exit,
}

export var bgm = ""

################################################################################
# PRIVATE METHODS
################################################################################

func _change_state(state_name):
	_current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
	else:
		var new_state = _states_map[state_name]
		states_stack[0] = new_state

	_current_state = states_stack[0]

	if state_name != 'previous':
		_current_state.enter(self)

################################################################################

func _input(event):
	var state_name = _current_state.handle_input(self, event)
	if state_name:
		_change_state(state_name)

################################################################################

func _ready():
	states_stack.push_front($States/Idle)
	_current_state = states_stack[0]
	_change_state('idle')

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	_change_state('process')

################################################################################

func hide_secondary_panels():
	for panel in secondary_panels.get_children():
		panel.visible = false

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Back_pressed() -> void:
	_change_state('exit')

################################################################################

func _on_Controls_pressed():
	hide_secondary_panels()
	_controls.visible = true

################################################################################

func _on_DefaultSettings_pressed():
	SettingsMaster.load_default_settings()

################################################################################

func _on_Display_pressed():
	hide_secondary_panels()
	_display.visible = true

################################################################################

func _on_KeybindPopup_new_keybind(action, event):
	SettingsMaster.set_controls_action(action, event.scancode)
	get_tree().call_group("settings", "update_setting")
	get_tree().call_group("settings_buttons", "enable")

################################################################################

func _on_Keybind_request_keybind_popup(action):
	keybind_popup.enable(action)
	get_tree().call_group("settings_buttons", "disable")

################################################################################

func _on_SaveSettings_pressed():
	SettingsMaster.save_settings()

################################################################################

func _on_Sound_pressed():
	hide_secondary_panels()
	_sound.visible = true
