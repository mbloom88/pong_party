extends "res://actors/common/state_scripts/state.gd"

export (float) var base_move_speed = 800.0
export (float) var move_speed_increase_factor = 1.01

################################################################################
# PUBLIC METHODS
################################################################################
func enter(host):
	host.velocity *= base_move_speed


func update(host: Object, delta: float) -> void:
	var collision: KinematicCollision2D = \
		host.move_and_collide(host.velocity * delta)
	
	if collision:
			host.velocity = host.velocity.bounce(collision.normal)
			host.velocity *= move_speed_increase_factor
			host.sfx._play_bounce()
