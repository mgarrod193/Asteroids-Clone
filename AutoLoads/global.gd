extends Node

#vars for storing player variables
var player_name : String
var player_list = []

var score = 0

func _ready() -> void:
	#silent wolf setup and configure
	SilentWolf.configure({
		"api_key": "XXXXX",
		"game_id": "XXXXX",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})


func _physics_process(delta: float) -> void:
	leaderboard()

#gets list of players
func leaderboard():
	for score in Global.score:
		Global.player_list.append(Global.player_name)
