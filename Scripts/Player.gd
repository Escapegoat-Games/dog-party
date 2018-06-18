# Controls Player movement

extends KinematicBody2D

onready var sprite = $PlayerSprite
onready var sprite_ani = $PlayerSprite/SpriteAnimation

var walk_speed = 50
var jump_speed = 2
var y_velocity = 0
var touching_ground = false
var is_play_land = false

const gravity = 0.1

enum State {
	IDLE,
	WALK,
	JUMP,
	LAND,
}
var state = State.IDLE

func _ready():
	pass

func _physics_process(delta):
	
	# raycast for ground
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(
		global_position,
		global_position+Vector2(0, 15),
		[self]
	)
	touching_ground = result.has("rid")
	
	# apply physics
	move_and_collide(Vector2(0, y_velocity))
	
	if touching_ground:
		y_velocity = 0
	else:
		y_velocity += gravity

func _process(delta):
	
	if touching_ground:
		state = State.IDLE
	
	# walking
	if Input.is_action_pressed("move_left"):
		move_and_slide(Vector2(-walk_speed, 0))
		sprite.flip_h = false
		if touching_ground:
			state = State.WALK
		else:
			state = State.JUMP
	elif Input.is_action_pressed("move_right"):
		move_and_slide(Vector2(walk_speed, 0))
		sprite.flip_h = true
		if touching_ground:
			state = State.WALK
		else:
			state = State.JUMP
	
	# jump
	if Input.is_action_pressed("jump") and touching_ground:
		y_velocity = -jump_speed
		state = State.JUMP
	
	#print(touching_ground, state)
	
	# animation
	if state == State.IDLE:
		sprite_ani.stop()
		sprite.frame = 0
	elif state == State.WALK and not sprite_ani.is_playing():
		sprite_ani.play("Walking")
	elif state == State.JUMP:
		sprite.frame = 5
	elif state == State.LAND:
		sprite_ani.play("Land")
