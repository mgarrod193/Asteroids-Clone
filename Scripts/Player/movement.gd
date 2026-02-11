extends Node

var player: CharacterBody2D

#Variables for speed and rotation speed
var max_speed := 200.0
var forward_impulse := 100.0
var drag := 150.0
var rotation_force := 120

#margin for smoother screenwrap
var margin := 16

func _ready() -> void:
	#Getting parent player node as CharacterBody2D to allow physics + velocity
	player = get_parent() as CharacterBody2D
	#Throws error if parent is not correct node type
	if player == null:
		push_error("Parent is not a CharacterBody2D")

func _physics_process(delta: float) -> void:
	_player_movement(delta)

#called every frame
func _process(_delta: float) -> void:
	_screen_wrap()

#Gets player direction, checks for input and adds velocity 
func _player_movement(delta: float):
	#Checks for player input
	if (Input.is_action_pressed("forward")):
		#Get players current angle and apply forward thrust
		var direction = Vector2.UP.rotated(player.rotation)
		player.velocity += direction * forward_impulse
	else:
		# Reduce players velocity to zero by drag factor amount
		player.velocity = player.velocity.move_toward(Vector2.ZERO, 
												drag * delta)
	
	if (Input.is_action_pressed("rotate_right")):
		player.rotation_degrees += rotation_force * delta
		
	if (Input.is_action_pressed("rotate_left")):
		player.rotation_degrees -= rotation_force * delta
	
	#Cap the players max speed
	player.velocity = player.velocity.limit_length(max_speed)
	
	player.move_and_slide()

# Gets visible screen size allows player to screen wrap
func _screen_wrap():
	var screen_size = get_viewport().get_visible_rect().size
	player.position.x = wrapf(player.position.x, 0, screen_size.x + margin)
	player.position.y = wrapf(player.position.y, 0, screen_size.y + margin)
	
