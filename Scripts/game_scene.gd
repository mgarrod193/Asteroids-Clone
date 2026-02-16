extends Node

@export var asteroid_scene: PackedScene
@export var waves: Array[wavesData]
@export var menu_wave: wavesData

const min_asteroid_velocity := 10.0
const max_asteroid_velocity := 75.0

#variables for game state
var lives := 3 
var score := 0
var cur_wave := 0
var game_started := false

#caching node references on startup
@onready var hud = $HUD 
@onready var menu = $Menus
@onready var player = $Player
@onready var starting_pos = $StartingPos.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.hide()
	_spawn_wave(menu_wave)

func _process(delta: float) -> void:
	if game_started && get_tree().get_node_count_in_group("Asteroids") == 0:
		if cur_wave < waves.count(wavesData):
			cur_wave += 1
		_spawn_wave(waves[cur_wave])

#called when play button pressed sets up initial game scene, lives and score
func start_game():
	lives = 3
	score = 0
	cur_wave = 0
	hud.reset_lives_and_score(lives, score)
	get_tree().call_group("Asteroids", "queue_free")
	menu.hide()
	player.position = starting_pos
	player.show()
	_spawn_wave(waves[cur_wave])
	game_started = true
	player.is_invulnerable = false

#Spawns Asteroid
func _spawn_wave(wave: wavesData) -> void:
	print(cur_wave)
	for i in range(wave.amount_to_spawn):
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
	if lives > 1:
		lives -= 1 
		hud.lose_life(lives)
		player.position = starting_pos
	else:
		game_over()

func asteroid_destroyed(scoreincrease: int):
	score += scoreincrease
	hud.update_score(score)

func game_over():
	player.hide()
	get_tree().call_group("Asteroids", "queue_free")
	menu.update_menu_message("You Lose!")
	menu.show()
