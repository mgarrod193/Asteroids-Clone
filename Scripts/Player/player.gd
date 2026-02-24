extends CharacterBody2D

signal hit

var is_invulnerable = true
var can_move = true

@onready var invuln_timer = $InvulnTimer
@onready var collision_shape = $Hitbox/CollisionPolygon2D
@onready var sprite = $Sprite2D


func _on_hitbox_body_entered(body: Node2D) -> void:
	#player hit by asteroid logic
	if body.is_in_group("Asteroids") and !is_invulnerable:
		collision_shape.set_deferred("disabled", true)
		hit.emit()
		is_invulnerable = true
		invuln_timer.start()
		
		#makes player flash while invulnerable
		while is_invulnerable:
			sprite.modulate = Color.RED
			await get_tree().create_timer(0.2).timeout
			sprite.modulate = Color.WHITE
			await get_tree().create_timer(0.2).timeout

#Sets player to vulnerable again and enables collisions to resume normal collisions 
func _on_invuln_timer_timeout() -> void:
	is_invulnerable = false
	collision_shape.set_deferred("disabled", false)
