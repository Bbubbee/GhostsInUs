extends Label

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.increase_score.connect(_on_increase_score)


func _on_increase_score(): 
	score += 1
	text = "score: " + str(score)
