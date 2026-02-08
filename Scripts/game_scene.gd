extends Node

@export var asteroid_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position = $StartingPos.position


func _on_asteroid_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	
	# Picks randon location on SpawnPath
	var asteroid_spwan_location = $SpawnPath/PathFollow2D
	asteroid_spwan_location.progress_ratio = randf()
	
	asteroid.position = asteroid_spwan_location.position
	
	#Sets direction perpendicular to spawnpath line
	var direction = asteroid_spwan_location.rotation + PI/2
	
	#adds variance
	direction += randf_range(-PI/4, PI/4)
	asteroid.rotation = direction
	
	#gives asteroid speed
	var velocity = Vector2(randf_range(50.0, 150.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	asteroid.add_to_group("Asteroids")
	
	add_child(asteroid)
