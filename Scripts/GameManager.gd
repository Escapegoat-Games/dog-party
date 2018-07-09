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
	start_title()

func _process(delta):
	if game_state == GameState.GAME:
		time_left -= delta
		
		if time_left <= 0:
			#unload_level()
			ScreenHandler.load_queue = [
				ScreenHandler.Scene.TIME,
				ScreenHandler.Scene.SCORE,
				ScreenHandler.Scene.FADE_OUT,
				ScreenHandler.Scene.TITLE
			]
			game_state = GameState.TITLE
			reset_game()

func start_title():
	ScreenHandler.load_queue = [
		ScreenHandler.Scene.TITLE,
	]
	game_state = GameState.TITLE
func start_game():
	ScreenHandler.load_queue = [
		ScreenHandler.Scene.FADE_OUT,
		ScreenHandler.Scene.GAME
	]
	
	game_state = GameState.GAME
	load_level(1)	# load random level later

func load_level(n):
	curr_level = levels[n].instance()
	add_child(curr_level)
func unload_level():
	remove_child(curr_level)

func reset_game():
	player_points = 0
	time_left = 10
	
func num2label(p):
	return  String((p/1000) % 10) + String((p/100) % 10) + String((p/10) % 10) + String(p % 10)
