extends CanvasLayer

#list of labels for player score and name
@export var player_names_label : Array[Label]
@export var player_scores_label : Array[Label]

var player_list_with_pos = []

func _ready() -> void:
	refresh_boards()

func refresh_boards():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(7).sw_get_scores_complete
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	add_players(player_list_with_pos)

#Gives each player a position
func sort_players_and_add_position(player_list):
	var position = 1
	
	for player in player_list:
		player["position"] =  position
		position += 1
		
	return player_list

#adds player into the high score scene
func add_players(player_list):
	var pos = 0
	for score_data in player_list:
		player_names_label[pos].set_text(str(score_data["player_name"]))
		player_scores_label[pos].set_text(str(int(score_data["score"])))
		pos += 1

func _on_button_pressed() -> void:
	get_parent().back_to_menu()
