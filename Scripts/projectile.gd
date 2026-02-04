extends Area2D

class_name Projectile

#Resource Data
@export var data: projectileData

var direction: Vector2

func _ready():
	#Throws error if projectile data not found
	assert(data != null, "ProjectileData not assigned")

	#Sets the Sprite of the projectile
	if data.sprite:
		$Sprite2D.texture = data.sprite

	#creates timer that delets bullet once lifetime expires
	await get_tree().create_timer(data.lifetime).timeout
	queue_free()

#Gives the bullet speed and direction
func _physics_process(delta):
	global_position += direction * data.speed * delta
