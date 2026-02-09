extends CanvasLayer

var score := 0
var score_text

var lives := 3
var lives_text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_text = $ScoreText
	lives_text = $LivesText
	Reset_Score_and_lives()

#Increase score by set amount and updates text
func Increase_Score(IncreaseScore: int):
	score += IncreaseScore
	score_text.set_text("Score: " + str(score))

#reduces players lives and updates text
func Lose_Life():
	lives -= 1
	lives_text.set_text("Lives: " + str(lives))

#resets score and lives values back to default
func Reset_Score_and_lives():
	score = 0
	score_text.set_text("Score: " + str(score))
	
	lives = 3
	lives_text.set_text("Lives: " + str(lives))
