extends RigidBody2D

var margin = 32

func _process(_delta: float) -> void:
	_screen_wrap()

func _physics_process(delta: float) -> void:
	rotation_degrees += randf_range(15, 90) * delta

# Gets visible screen size allows player to screen wrap
func _screen_wrap():
	var screen_size = get_viewport().get_visible_rect().size
	position.x = wrapf(position.x, 0, screen_size.x + margin)
	position.y = wrapf(position.y, 0, screen_size.y + margin)

#called when hit by projectile
func Destroyed():
	queue_free()
