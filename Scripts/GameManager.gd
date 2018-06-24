# Manages game info

extends Node2D

enum GameState {
	TITLE,
	GAME
}
var game_state

var player_points = 0
var time_left = 100

func _ready():
	game_state = GameState.GAME

func _process(delta):
	if game_state == GameState.GAME:
		time_left -= delta