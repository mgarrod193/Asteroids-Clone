extends CanvasLayer

@onready var enter_name: LineEdit = $Panel/VBoxContainer/HBoxContainer/EnterName
@onready var game_scene = get_parent()

func _on_submit_button_pressed() -> void:
	Global.player_name = enter_name.text
	var sw_result : Dictionary = await SilentWolf.Scores.save_score(Global.player_name, Global.score).sw_save_score_complete
	print("score persisted successfully: " + str(sw_result.score_id))
	game_scene.go_to_high_score_screen()
	self.hide()
