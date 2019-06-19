extends Control

signal add_menu(menu)
signal level_selected(selections)
signal state_changed(menu, states_stack)

onready var _back = $NinePatchRect/HBoxContainer/ButtonPanel/VBoxContainer/ \
	FinalButtons/Back
onready var _level_description = $NinePatchRect/HBoxContainer/Previews/ \
	NinePatchRect2/LevelDescription
onready var _level_preview = $NinePatchRect/HBoxContainer/Previews/ \
	NinePatchRect/LevelPreview
onready var animation = $AnimationPlayer
onready var level_buttons = $NinePatchRect/HBoxContainer/ButtonPanel/ \
	VBoxContainer/LevelButtons
onready var player_buttons = $NinePatchRect/HBoxContainer/ButtonPanel/ \
	VBoxContainer/PlayerButtons
onready var difficulty_buttons = $NinePatchRect/HBoxContainer/ButtonPanel/ \
	VBoxContainer/AIDifficultyButtons
onready var final_buttons = $NinePatchRect/HBoxContainer/ButtonPanel/ \
	VBoxContainer/FinalButtons
onready var _goals = $NinePatchRect/HBoxContainer/ButtonPanel/VBoxContainer/ \
	Goals
onready var start_game = $NinePatchRect/HBoxContainer/ButtonPanel/\
	VBoxContainer/FinalButtons/StartGame

var _current_state = null
var states_stack = []

onready var _states_map = {
	'idle': $States/Idle,
	'process': $States/Process,
	'exit': $States/Exit,
}

export var bgm = ""
export var level_descriptions_file = ""

onready var selections = {
	'difficulty': "",
	'level': "",
	'players': 0,
	'goals': _goals.get_node("GoalNumber").min_value,
}

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

func _display_level_description(level):
	var file = File.new()
	file.open(level_descriptions_file, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	
	_level_description.bbcode_text = json_data[level]

################################################################################

func _input(event):
	var state_name = _current_state.handle_input(self, event)
	if state_name:
		_change_state(state_name)

################################################################################

func _process(delta):
	var state_name = _current_state.update(self, delta)
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
# SIGNAL HANDLING
################################################################################

func _on_AIDifficultyButtons_difficulty_selected(difficulty):
	selections['difficulty'] = difficulty

################################################################################

func _on_Back_pressed():
	_change_state('exit')

################################################################################

func _on_Goals_goal_selected(goal):
	selections['goals'] = goal

################################################################################

func _on_LevelButtons_level_selected(level):
	selections['level'] = level

################################################################################

func _on_LevelButtons_video_selected(level, video):
	_level_preview.play_video(video)
	_display_level_description(level.to_lower())

################################################################################

func _on_PlayerButtons_players_selected(players):
	selections['players'] = players

################################################################################

func _on_StartGame_pressed():
	emit_signal("level_selected", selections)
