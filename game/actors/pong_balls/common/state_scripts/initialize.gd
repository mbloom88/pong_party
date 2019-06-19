extends "res://actors/common/state_scripts/state.gd"

export (int) var starting_angle_min = 15
export (int) var starting_angle_max = 30

################################################################################
# PUBLIC METHODS
################################################################################
func enter(host):
	host.set_physics_process(false)
	
	randomize()
	var h_flip: int = randi() % 2
	var v_flip: int = randi() % 2
	var angle: int = (randi() % starting_angle_max + starting_angle_min)

	if h_flip:
		angle = 180 - angle 
	
	if v_flip:
		angle *= -1 

	var x: float = cos(deg2rad(angle))
	var y: float = sin(deg2rad(angle))

	host.velocity = Vector2(x, y)

func exit(host):
	host.set_physics_process(true)
