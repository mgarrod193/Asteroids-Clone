extends RigidBody2D

var margin_pixels = 16
var margin

#viariables for asteroid spin
var min_angular_velocity := -0.8
var max_angular_veloctiy := 0.8

#variables for asteroid speed
var min_asteroid_velocity := 10.0
var max_asteroid_velocity := 75.0

var score
 
var current_size: Vector2
@onready var asteroid_scene: PackedScene = preload("res://Scenes/Asteroid.tscn")
@onready var screen_size = get_viewport().get_visible_rect().size

func _ready() -> void:
	current_size = $Sprite2D.scale
	angular_velocity =  randf_range(min_angular_velocity, max_angular_veloctiy)
	margin = margin_pixels * current_size.x

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	_screen_wrap()

#sets the scale of the asteroid
func set_new_scale(new_scale: Vector2):
	$Sprite2D.scale = new_scale
	$CollisionShape2D.scale = new_scale
	

# Gets visible screen size allows player to screen wrap
func _screen_wrap():
	position.x = wrapf(position.x, 0, screen_size.x + margin)
	position.y = wrapf(position.y, 0, screen_size.y + margin)

#called when hit by projectile
func Destroyed():
	$CollisionShape2D.set_deferred("disabled", true)
	
	var new_asteroid
	
	#creates 2 to 3 new asteroids if not the smallest asteroid size.
	if current_size > Vector2(0.5, 0.5):
		for i in range(randi_range(2,3)):
			new_asteroid = asteroid_scene.instantiate()
			
			#gives new asteroid position, direction and velocity
			new_asteroid.position = position
			new_asteroid.set_new_scale($Sprite2D.scale * 0.5)
			var direction = new_asteroid.rotation + randf_range(0, TAU)
			var velocity = Vector2(randf_range(min_asteroid_velocity, max_asteroid_velocity), 0.0)
			new_asteroid.linear_velocity = velocity.rotated(direction)
			
			new_asteroid.score = score * 2
			new_asteroid.add_to_group("Asteroids")
			
			get_parent().call_deferred("add_child", new_asteroid)
			
	
	get_parent().asteroid_destroyed(score)
	queue_free()
	
