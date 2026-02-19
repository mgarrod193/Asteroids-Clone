extends Node

@export var explosion_pfx: PackedScene
@export var asteroid_scene: PackedScene
@export var waves: Array[wavesData]
@export var menu_wave: wavesData

const min_asteroid_velocity := 30.0
const max_asteroid_velocity := 90.0

#variables for game state
var lives := 3 
var score := 0
var high_score:int
var cur_wave := 0
var game_started := false

#caching node references on startup
@onready var hud := $HUD 
@onready var menu := $Menus
@onready var high_score_panel := $HighScoreScreen
@onready var player := $Player
@onready var starting_pos = $StartingPos.position
@onready var explosion_sound := $ExplosionSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_player()
	high_score = Global.high_score
	_spawn_wave(menu_wave)

func _process(delta: float) -> void:
	if game_started && get_tree().get_node_count_in_group("Asteroids") == 0:
		if cur_wave < waves.size()-1:
			cur_wave += 1
		_spawn_wave(waves[cur_wave])

#called when play button pressed sets up initial game scene, lives and score
func start_game():
	#reset variables
	lives = 3
	score = 0
	cur_wave = 0
	
	#update hud values
	hud.reset_lives_and_score(lives, score)
	
	#remove pre-existing asteroids
	get_tree().call_group("Asteroids", "queue_free")
	
	
	menu.hide()
	enable_player()
	_spawn_wave(waves[cur_wave])
	game_started = true

	
#Spawns Asteroid
func _spawn_wave(wave: wavesData) -> void:
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

#function to remove player lives, update hud and reset players poisiton, triggers game
#over if player is out of lives
func _on_player_hit() -> void:
	if lives > 1:
		lives -= 1 
		hud.lose_life(lives)
		player.position = starting_pos
	else:
		game_over()

#increase score by asteroid destroyed score value and updates hud
func asteroid_destroyed(scoreincrease: int, asteroid_pos: Vector2):
	var explosion_effect = explosion_pfx.instantiate()
	explosion_effect.position = asteroid_pos
	explosion_effect.emitting = true
	add_child(explosion_effect)
	
	score += scoreincrease
	hud.update_score(score)
	explosion_sound.play()

#used too enable player controls, reset position and show
func enable_player():
	player.can_move = true
	player.is_invulnerable = false
	player.position = starting_pos
	player.show()
	

func disable_player():
	player.can_move = false
	player.is_invulnerable = true
	player.hide()

#called when player runs out of lives, hides player and displays game menu
func game_over():
	game_started = false
	disable_player()
	get_tree().call_group("Asteroids", "queue_free")
	menu.update_menu_message("Score: " + str(score),"You Lose!")
	menu.show()

func go_to_high_score_screen():
	menu.hide()
	high_score_panel.show()

func back_to_menu():
	high_score_panel.hide()
	menu.show()
