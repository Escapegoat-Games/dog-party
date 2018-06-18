extends KinematicBody2D

var speed = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	# controls
	if Input.is_action_pressed("move_left"):
		move_and_slide(Vector2(-speed, 0))
	elif Input.is_action_pressed("move_right"):
		move_and_slide(Vector2(speed, 0))
