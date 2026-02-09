extends RigidBody2D

var margin = 16

var min_angular_velocity := 0.2
var max_angular_veloctiy := 0.8


func _physics_process(delta: float) -> void:
	angular_velocity =  randf_range(min_angular_velocity, max_angular_veloctiy)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	_screen_wrap()

# Gets visible screen size allows player to screen wrap
func _screen_wrap():
	var screen_size = get_viewport().get_visible_rect().size	
	position.x = wrapf(position.x, 0, screen_size.x + margin)
	position.y = wrapf(position.y, 0, screen_size.y + margin)

#called when hit by projectile
func Destroyed():
	queue_free()
