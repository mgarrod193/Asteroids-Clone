extends Node

@export var asteroid_scene: PackedScene

const min_asteroid_velocity := 10.0
const max_asteroid_velocity := 75.0

@onready var hud = $HUD 
@onready var menu = $Menus
@onready var player = $Player
@onready var starting_pos = $StartingPos.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.hide()

#called when play button pressed
func start_game():
	get_tree().call_group("Asteroids", "queue_free")
	menu.hide()
	player.position = starting_pos
	player.show()

#Spawns Asteroid
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
	var velocity = Vector2(randf_range(min_asteroid_velocity, max_asteroid_velocity), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	asteroid.score = 10
	asteroid.add_to_group("Asteroids")
	
	add_child(asteroid)


func _on_player_hit() -> void:
	hud.Lose_Life()
	player.position = starting_pos

func asteroid_destroyed(scoreincrease: int):
	hud.Increase_Score(scoreincrease)
