extends CharacterBody2D

signal hit

var _is_invulnerable = false

@onready var invuln_timer = $InvulnTimer
@onready var collision_shape = $Hitbox/CollisionPolygon2D

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Asteroids"):
		collision_shape.set_deferred("disabled", true)
		hit.emit()
		_is_invulnerable = true
		invuln_timer.start()

#Sets player to vulnerable again and enables collisions to resume normal collisions 
func _on_invuln_timer_timeout() -> void:
	_is_invulnerable = false
	collision_shape.set_deferred("disabled", false)
