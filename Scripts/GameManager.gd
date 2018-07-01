# Manages game info + level loading
extends Node2D

enum GameState {
	TITLE,
	GAME,
}
var game_state

var player_points = 0
var time_left = 10

# Levels and screens
var levels = [
	load("res://Scenes/Levels/Level01.tscn"),
	load("res://Scenes/Levels/Level02.tscn"),
	load("res://Scenes/Levels/Level03.tscn"),
]
var curr_level

func _ready():
	game_state = GameState.GAME
	load_level(1)

func _process(delta):
	if game_state == GameState.GAME:
		time_left -= delta
		
		if time_left <= 0:
			#unload_level()
			ScreenHandler.load_queue = [
				ScreenHandler.Screen.TIME,
				ScreenHandler.Screen.SCORE,
				ScreenHandler.Screen.FADE_TRANS,
			]
			game_state = GameState.TITLE


func load_level(n):
	curr_level = levels[n].instance()
	add_child(curr_level)
func unload_level():
	remove_child(curr_level)
	
func num2label(p):
	return  String((p/1000) % 10) + String((p/100) % 10) + String((p/10) % 10) + String(p % 10)
