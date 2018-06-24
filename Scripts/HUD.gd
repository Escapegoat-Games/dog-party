extends CanvasLayer

onready var score_label = $GUI/VBoxContainer/Score
onready var time_label = $GUI/VBoxContainer/Time

func _ready():
	score_label.get_font("font").create_from_fnt("res://Font/custom.fnt")
	time_label.get_font("font").create_from_fnt("res://Font/custom.fnt")

func _process(delta):
	score_label.text = "SCORE:" + num2label(GameManager.player_points)
	time_label.text = "TIME: " + num2label(int(GameManager.time_left))
	

func num2label(p):
	return  String((p/1000) % 10) + String((p/100) % 10) + String((p/10) % 10) + String(p % 10)