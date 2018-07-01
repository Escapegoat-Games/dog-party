extends Node

enum Screen {
	TIME,
	FADE_OUT,
	FADE_IN,
	FADE_TRANS,
	SCORE,
}

var screens = [
	load("res://Scenes/Screens/TimeScreen.tscn"),
	load("res://Scenes/Screens/FadeOutScreen.tscn"),
	load("res://Scenes/Screens/FadeInScreen.tscn"),
	load("res://Scenes/Screens/FadeTransScreen.tscn"),
	load("res://Scenes/Screens/ScoreScreen.tscn"),
]
var curr_screen

var ready_to_load = true
var load_queue = []

func _process(delta):
	# Load next screen in queue
	if ready_to_load and len(load_queue) > 0:
		load_screen(load_queue.pop_front())
		ready_to_load = false

func load_screen(n):
	curr_screen = screens[n].instance()
	get_node("/root/Game/HUD/Screen").add_child(curr_screen)