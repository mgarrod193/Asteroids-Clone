extends Node2D

@export var bullet_scene : PackedScene

var weapon_on_cooldown := false
var player: CharacterBody2D

@onready var shoot_sfx := $AudioStreamPlayer2D

func _ready() -> void:
	#Getting parent player node as CharacterBody2D to allow physics + velocity
	player = get_parent() as CharacterBody2D
	#Throws error if parent is not correct node type
	if player == null:
		push_error("Parent is not a CharacterBody2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		#check for player input and shoot bullet if true
		if Input.is_action_just_pressed("shoot") && !weapon_on_cooldown && player.can_move:
			_shoot()

#creates bullet_scene and adds into game
func _shoot():
	shoot_sfx.play()
	
	# creating bullet instance and Spawn pos transform
	var bullet = bullet_scene.instantiate()
	var spawn_transform = $BulletSpawnPos.get_global_transform()
	
	#sets bullet spawn position, direction and group
	bullet.global_position = spawn_transform.origin
	bullet.direction = Vector2.UP.rotated(get_parent().rotation)
	bullet.add_to_group("bullets")
	
	#adds root scene tree
	get_tree().current_scene.add_child(bullet)
	
	#puts weapon on cooldown
	weapon_on_cooldown = true
	await get_tree().create_timer(bullet.data.weapon_cooldown).timeout
	weapon_on_cooldown = false
