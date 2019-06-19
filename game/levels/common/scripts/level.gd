extends Node

signal request_victory_menu
signal victory_achieved(music)

onready var _sfx = $SFX
onready var _ball_container = $BallContainer
onready var _countdown = $ForeDisplays/Countdown
onready var _victory = $ForeDisplays/Victory
onready var _debug = $Debug
onready var _debug_speed = $Debug/PongBallSpeed
onready var _debug_pos = $Debug/PongBallPosition
onready var _location_ball = $StartingLocations/Ball.position
onready var _location_leftside = $StartingLocations/LeftSide.position
onready var _location_rightside = $StartingLocations/RightSide.position
onready var _paddles = $PaddleContainer
onready var _score1 = $BackDisplays/Player1Score
onready var _score2 = $BackDisplays/Player2Score

export var player1_paddle_gfx = ""
export var player2_paddle_gfx = ""
export var npc_paddle_gfx = ""
export var ball_gfx = ""

export var bgm = ""
export var victory_music = ""

export var debug_mode_enabled = false
var _new_game = true

var _ball = null
var _player1  = null 
var _player2 = null 
var ai_difficulty = "" setget set_ai_difficulty
var goal_victory = 0 setget set_goal_victory
var number_of_players = "" setget set_number_of_players

################################################################################
# PRIVATE METHODS
################################################################################

func _initialize():
	_countdown.stop()
	_remove_pong_ball()
	
	_ball = load(ball_gfx).instance() 
	_ball_container.add_child(_ball)
	
	if _new_game:
		_new_game = false
		
		_player1 = load(player1_paddle_gfx).instance() 
		_paddles.add_child(_player1)
		_player1.player_number = 1
		
		match number_of_players:
			1:
				_player2 = load(npc_paddle_gfx).instance() 
			2:
				_player2 = load(player2_paddle_gfx).instance() 
		
		_paddles.add_child(_player2)
	
	if number_of_players == 1:
		_player2.ball_target = _ball
		_player2.difficulty = ai_difficulty
	elif number_of_players == 2:
		_player2.player_number = 2
		
	_ball.position = _location_ball
	_player1.position = _location_leftside
	_player2.position = _location_rightside
	
	_countdown.countdown()

################################################################################

func _physics_process(delta):
	if _ball_container.get_child_count() != 0:
		_debug_speed.text = "Ball Speed: %0.3f pixels/s, x-dir %d" % [
			_ball.velocity.length(), sign(_ball.velocity.x)]
		_debug_pos.text = "Ball Position: %s" % _ball.position

################################################################################

func _remove_pong_ball():
	if _ball_container.get_child_count() != 0:
		_ball_container.get_child(0).queue_free()

################################################################################

func _ready():
	toggle_debug_mode()

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	_initialize()

################################################################################

func rematch():
	_player1.activate()
	_player2.activate()
	_score1.reset_score()
	_score2.reset_score()
	_initialize()

################################################################################

func reset_field():
	_initialize()

################################################################################

func toggle_debug_mode():
	if debug_mode_enabled:
		for debug in _debug.get_children():
			debug.visible = true
	else:
		set_physics_process(false)
		
		for debug in _debug.get_children():
			debug.visible = false

################################################################################
# SETTERS/GETTERS
################################################################################

func set_ai_difficulty(value):
	ai_difficulty = value

################################################################################

func set_goal_victory(value):
	goal_victory = value

################################################################################

func set_number_of_players(value):
	number_of_players = value

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Victory_animations_completed():
	emit_signal("request_victory_menu")
