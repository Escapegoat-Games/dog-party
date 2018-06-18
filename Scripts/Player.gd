# Controls Player movement

extends KinematicBody2D

onready var sprite = $PlayerSprite

var walk_speed = 50
var jump_speed = 2
var y_velocity = 0
var touching_ground = false
const gravity = 0.1

enum State {
	IDLE,
	WALK,
	JUMP,
}
var state = State.IDLE

func _ready():
	pass

func _process(delta):
	
	state = State.IDLE
	
	# walking
	if Input.is_action_pressed("move_left"):
		move_and_slide(Vector2(-walk_speed, 0))
		state = State.WALK
	elif Input.is_action_pressed("move_right"):
		move_and_slide(Vector2(walk_speed, 0))
		state = State.WALK
	
	# jump
	if Input.is_action_pressed("jump") and touching_ground:
		y_velocity = -jump_speed
	
	# gravity
	if move_and_collide(Vector2(0, y_velocity)):
		touching_ground = true
		y_velocity = 0
	else:
		touching_ground = false
		y_velocity += gravity
	
	
	print(touching_ground)
