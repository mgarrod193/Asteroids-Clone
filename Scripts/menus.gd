extends CanvasLayer

@onready var game_scene := get_parent()

func _on_play_button_button_down() -> void:
	game_scene.start_game()
