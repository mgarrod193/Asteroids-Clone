extends Node

@export var asteroid_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position = $StartingPos.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_asteroid_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	
	var asteroid_spwan_location = $SpawnPath/PathFollow2D
	asteroid_spwan_location.progress_ratio = randf()
	
	asteroid.position = asteroid_spwan_location.position
	
	var direction = asteroid_spwan_location.rotation + PI/2
	
	direction += randf_range(-PI/4, PI/4)
	asteroid.rotation = direction
	
	var velocity = Vector2(randf_range(50.0, 150.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)
