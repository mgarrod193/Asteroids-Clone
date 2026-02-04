extends Node

@export var bullet_scene : PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		#check for player input and shoot bullet if true
		if Input.is_action_just_pressed("shoot"):
			_shoot()

#creates bullet_scene and adds into game
func _shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = $BulletSpawnPos.position
	bullet.add_to_group("bullets")
	get_tree().current_scene.add_child(bullet)
	print("fired")
	
