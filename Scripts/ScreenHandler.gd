extends Node

enum Screen {
	TIME,
	FADE_OUT,
	FADE_IN,
	FADE_TRANS,
	SCORE,
	
	TITLE,
	GAME,
}


var screens = [
	load("res://Scenes/Screens/TimeScreen.tscn"),
	load("res://Scenes/Screens/FadeOutScreen.tscn"),
	load("res://Scenes/Screens/FadeInScreen.tscn"),
	load("res://Scenes/Screens/FadeTransScreen.tscn"),
	load("res://Scenes/Screens/ScoreScreen.tscn"),
]
var curr_screen

var main_scenes = [
	load("res://Scenes/TitleScreen.tscn"),
	load("res://Scenes/Game.tscn"),
]
var curr_scene

var ready_to_load = true
var load_queue = []

func _process(delta):
	# Load next screen in queue
	if ready_to_load and len(load_queue) > 0:
		var obj = load_queue.pop_front()
		if obj < len(screens):
			load_screen(obj)
			ready_to_load = false
		else:
			if curr_scene != null:
				curr_scene.queue_free()
			curr_scene = main_scenes[obj-len(screens)].instance()
			get_node("/root/Main/Current").add_child(curr_scene)

func load_screen(n):
	curr_screen = screens[n].instance()
	get_node("/root/Main/CanvasLayer/Screen").add_child(curr_screen)