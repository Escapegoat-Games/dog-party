extends Node

enum Scene {
	TIME,
	FADE_OUT,
	FADE_IN,
	FADE_TRANS,
	SCORE,
	TITLE,
	GAME,
	BLANK,
}
enum SceneType {
	SCREEN,
	MAIN,
}


var scenes = [
	load("res://Scenes/Screens/TimeScreen.tscn"),
	load("res://Scenes/Screens/FadeOutScreen.tscn"),
	load("res://Scenes/Screens/FadeInScreen.tscn"),
	load("res://Scenes/Screens/FadeTransScreen.tscn"),
	load("res://Scenes/Screens/ScoreScreen.tscn"),
	load("res://Scenes/TitleScreen.tscn"),
	load("res://Scenes/Game.tscn"),
	load("res://Scenes/Blank.tscn"),
]

var parent_nodes = [
	"/root/Main/CanvasLayer/Screen",
	"/root/Main/CanvasLayer/Screen",
	"/root/Main/CanvasLayer/Screen",
	"/root/Main/CanvasLayer/Screen",
	"/root/Main/CanvasLayer/Screen",
	"/root/Main/Current",
	"/root/Main/Current",
	"/root/Main/Current",
]

var type_list = [
	SceneType.SCREEN,
	SceneType.SCREEN,
	SceneType.SCREEN,
	SceneType.SCREEN,
	SceneType.SCREEN,
	SceneType.MAIN,
	SceneType.MAIN,
	SceneType.MAIN,
]
var curr_main_scene
var curr_screen

var ready_to_load = true
var load_queue = []

func _process(delta):
	# Load next screen in queue
	if ready_to_load and len(load_queue) > 0:
		var obj = load_queue.pop_front()
		load_screen(obj)
		ready_to_load = false

func load_screen(n):
	match type_list[n]:
		SceneType.SCREEN:
			curr_screen = scenes[n].instance()
			get_node("/root/Main/CanvasLayer/Screen").add_child(curr_screen)
		SceneType.MAIN:
			curr_main_scene = scenes[n].instance()
			get_node("/root/Main/Current").add_child(curr_main_scene)

func free_current_scene():
	print(curr_screen)
	if curr_screen != null:
		curr_screen.queue_free()