extends CanvasLayer

onready var score_label = $GUI/VBoxContainer/Score

func _ready():
	score_label.get_font("font").create_from_fnt("res://Font/ubuntu.fnt")
	pass

func _process(delta):
	score_label.text = points2score(GameManager.player_points)

func points2score(p):
	return  String(p / 1000) + String(p / 100) + String(p / 10) + String(p % 10)