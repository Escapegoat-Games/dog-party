# Controls Player movement (still spaghet)

extends KinematicBody2D

onready var sprite = $PlayerSprite
onready var sprite_ani = $PlayerSprite/SpriteAnimation
onready var collision = $CollisionShape2D

var walk_speed = 50
var jump_speed = 3
var y_velocity = 0
var touching_ground = false
var land_cooldown

const gravity = 0.1

enum State {
	IDLE,
	WALK,
	JUMP,
}
var state = State.IDLE

func _ready():
	land_cooldown = sprite_ani.get_animation("Land").length

func _physics_process(delta):
	
	# raycast for ground
	var space_state = get_world_2d().direct_space_state
	var front_vec = global_position+Vector2(collision.shape.extents.x+collision.position.x, 0)
	var front_raycast = space_state.intersect_ray(
		front_vec,
		front_vec+Vector2(0, 13),
		[self],
		1
	)
	var back_vec = global_position+Vector2(-collision.shape.extents.x+collision.position.x, 0)
	var back_raycast = space_state.intersect_ray(
		back_vec,
		back_vec+Vector2(0, 13),
		[self],
		1
	)
	touching_ground = front_raycast.size() > 0 or back_raycast.size() > 0
	
	# apply physics
	move_and_collide(Vector2(0, y_velocity))
	
	if touching_ground:
		y_velocity = 0
	else:
		y_velocity += gravity
	
	# pixel perfect?
	#sprite.global_position = Vector2(int(global_position.x), int(global_position.y))

func _process(delta):
	
	# cool downs
	if land_cooldown >= 0:
		land_cooldown -= delta
	
	handle_controls()
	handle_animation()
	
func handle_controls():
	# set up default idle state
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

func handle_animation():
	
	# animation
	if state == State.IDLE and land_cooldown <= 0:
		sprite_ani.stop()
		sprite.frame = 0
	if state == State.WALK and not sprite_ani.is_playing():
		sprite_ani.play("Walking")
	elif state == State.JUMP:
		sprite.frame = 5
		
		if y_velocity > 1:
			sprite_ani.play("Land")
			land_cooldown = sprite_ani.get_animation("Land").length
