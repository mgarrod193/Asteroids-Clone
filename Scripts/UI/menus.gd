extends CanvasLayer

@onready var game_scene := get_parent()
@onready var title_text := $TitleText
@onready var panel_title := $Panel/PanelTitle

func _on_play_button_button_down() -> void:
	game_scene.start_game()

func update_menu_message(scoremessage: String ,message: String):
	title_text.set_text(scoremessage)
	panel_title.set_text(message)


func _on_high_score_button_pressed() -> void:
	game_scene.go_to_high_score_screen()
