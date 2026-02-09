extends CanvasLayer

var score := 0
var score_text

var lives := 3
var lives_text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_text = $ScoreText.text
	lives_text = $LivesText.text
	Reset_Score_and_lives()

func Increase_Score(IncreaseScore: int):
	score += IncreaseScore
	score_text = "Score: " + str(score)

func Lose_Life():
	lives -= 1
	lives_text = "Lives: " + str(lives)

func Reset_Score_and_lives():
	score = 0
	score_text = "score: " + str(score)
	
	lives = 3
	lives_text = "lives: " + str(lives)
