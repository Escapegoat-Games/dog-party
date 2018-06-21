extends CanvasLayer

onready var score_label = $GUI/VBoxContainer/Score

func _ready():
	score_label.get_font("font").create_from_fnt("res://Font/pixel.fnt")
	pass

func _process(delta):
	score_label.text = "Score : " + points2score(GameManager.player_points)

func points2score(p):
	return  String(p / 10) + String(p % 10)