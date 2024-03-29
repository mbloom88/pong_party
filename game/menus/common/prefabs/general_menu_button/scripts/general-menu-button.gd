extends Button

onready var _animation = $AnimationPlayer

################################################################################
# PRIVATE METHODS
################################################################################

func _ready():
	idle()

################################################################################
# PUBLIC METHODS
################################################################################

func disable():
	disabled = true

################################################################################

func enable():
	disabled = false
	
################################################################################

func idle():
	_animation.play("idle")

################################################################################

func pulse():
	_animation.play("pulse")
