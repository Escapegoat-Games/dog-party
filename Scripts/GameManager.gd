# Manages game info + level loading
extends Node2D

enum GameState {
	TITLE,
	GAME
}
var game_state

var player_points = 0
var time_left = 100

var levels = [
	load("res://Scenes/Levels/Level01.tscn"),
	load("res://Scenes/Levels/Level02.tscn"),
	load("res://Scenes/Levels/Level03.tscn"),
]
var level

func _ready():
	game_state = GameState.GAME
	load_level(0)

func _process(delta):
	if game_state == GameState.GAME:
		time_left -= delta

func load_level(n):
	level = levels[n].instance()
	add_child(level)