extends Node

var save_data:SaveData
var high_score: int = 0

func read():
	save_data = SaveData.load_or_create()
