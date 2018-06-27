# Handles animated screen and deletion

extends Node2D

onready var screen_ani = $AnimationPlayer

func _ready():
	screen_ani.play("PlayScreen")

func _process(delta):
	if not screen_ani.is_playing():
		queue_free()
		pass