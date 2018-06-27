# Manages game info + level loading
extends Node2D

enum GameState {
	TITLE,
	GAME,
}
var game_state

enum Screen {
	TIME,
	FADE_OUT,
	
}

var player_points = 0
var time_left = 10

# Levels and screens
var levels = [
	load("res://Scenes/Levels/Level01.tscn"),
	load("res://Scenes/Levels/Level02.tscn"),
	load("res://Scenes/Levels/Level03.tscn"),
]
var curr_level

var screens = [
	load("res://Scenes/Screens/TimeScreen.tscn"),
	load("res://Scenes/Screens/FadeOutScreen.tscn"),
]
var curr_screen

func _ready():
	game_state = GameState.GAME
	load_level(0)

func _process(delta):
	if game_state == GameState.GAME:
		time_left -= delta
		
		if time_left <= 0:
			#unload_level()
			load_screen(Screen.FADE_OUT)
			game_state = GameState.TITLE

func load_screen(n):
	curr_screen = screens[n].instance()
	get_node("/root/Game/HUD/Screen").add_child(curr_screen)

func load_level(n):
	curr_level = levels[n].instance()
	add_child(curr_level)
func unload_level():
	remove_child(curr_level)