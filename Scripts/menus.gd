extends CanvasLayer

@onready var game_scene := get_parent()
@onready var panel_title = $Panel/PanelTitle

func _on_play_button_button_down() -> void:
	game_scene.start_game()

func update_menu_message(message: String):
	panel_title.set_text(message)
