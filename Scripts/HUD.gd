extends CanvasLayer

onready var score_label = $GUI/VBoxContainer/Score
onready var time_label = $GUI/VBoxContainer/Time

func _ready():
	score_label.get_font("font").create_from_fnt("res://Font/custom.fnt")
	time_label.get_font("font").create_from_fnt("res://Font/custom.fnt")

func _process(delta):
	score_label.text = "SCORE:" + GameManager.num2label(GameManager.player_points)
	time_label.text = "TIME: " + GameManager.num2label(int(GameManager.time_left))
