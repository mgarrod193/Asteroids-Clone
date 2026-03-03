extends Node

var player_name : String
var player_list = []

var score = 0

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "api_key",
		"game_id": "game_id",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})


func _physics_process(delta: float) -> void:
	leaderboard()


func leaderboard():
	for score in Global.score:
		Global.player_list.append(Global.player_name)
