extends CharacterBody2D

signal hit

func _on_hitbox_body_entered(_body: Node2D) -> void:
		hit.emit()
