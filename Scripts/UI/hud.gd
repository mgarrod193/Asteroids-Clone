extends CanvasLayer

var score_text
var lives_text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_text = $ScoreText
	lives_text = $LivesText

#Increase score by set amount and updates text
func update_score(score: int):
	score_text.set_text("Score: " + str(score))

#reduces players lives and updates text
func lose_life(lives: int):
	lives_text.set_text("Lives: " + str(lives))

#resets score and lives values back to default
func reset_lives_and_score(lives: int, score: int):
	score_text.set_text("Score: " + str(score))
	
	lives_text.set_text("Lives: " + str(lives))
