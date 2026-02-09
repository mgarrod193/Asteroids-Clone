extends CharacterBody2D

signal hit

func _on_hitbox_body_entered(body: Node2D) -> void:
		print("hit")
		hit.emit()
