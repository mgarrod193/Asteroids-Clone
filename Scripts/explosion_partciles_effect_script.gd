extends CPUParticles2D

#removes node once effect finished
func _on_finished() -> void:
	queue_free()
