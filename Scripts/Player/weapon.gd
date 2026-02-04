extends Node2D

@export var bullet_scene : PackedScene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		#check for player input and shoot bullet if true
		if Input.is_action_just_pressed("shoot"):
			_shoot()

#creates bullet_scene and adds into game
func _shoot():
	# creating bullet instance and Spawn pos transform
	var bullet = bullet_scene.instantiate()
	var spawn_transform = $BulletSpawnPos.get_global_transform()
	
	#sets bullet spawn position, direction and group
	bullet.global_position = spawn_transform.origin
	bullet.direction = Vector2.UP.rotated(get_parent().rotation)
	bullet.add_to_group("bullets")
	
	#adds root scene tree
	get_tree().current_scene.add_child(bullet)
