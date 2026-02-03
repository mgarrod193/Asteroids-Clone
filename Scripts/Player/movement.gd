extends Node

var player: CharacterBody2D

#Variables for speed and rotation speed
var max_speed := 300.0
var forward_impulse := 200.0
var drag := 150.0
var rotation_force := 3

func _ready() -> void:
	#Getting parent player node as CharacterBody2D to allow physics + velocity
	player = get_parent() as CharacterBody2D

func _physics_process(delta: float) -> void:
	_player_movement(delta)

func _process(delta: float) -> void:
	_screen_wrap()

#TODO ScreenWrapping
#Gets player direction, checks for input and adds velocity 
func _player_movement(delta: float):
	#Checks for player input
	if (Input.is_action_pressed("forward")):
		#Get players current angle and apply forward thrust
		var direction = Vector2.UP.rotated(player.rotation)
		player.velocity = direction * forward_impulse
	else:
		# Reduce players velocity to zero by drag factor amount
		player.velocity = player.velocity.move_toward(Vector2.ZERO, 
												drag * delta)
	
	if (Input.is_action_pressed("rotate_right")):
		player.rotation_degrees += rotation_force
		
	if (Input.is_action_pressed("rotate_left")):
		player.rotation_degrees -= rotation_force
	
	#Cap the players max speed
	player.velocity = player.velocity.limit_length(max_speed)
	
	player.move_and_slide()

#Wraps the screen
func _screen_wrap():
	player.position.x = wrapf(player.position.x, 0, player.screen_size.x)
	player.position.y = wrapf(player.position.y, 0, player.screen_size.y)
	
