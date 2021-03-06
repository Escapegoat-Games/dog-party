# Controls Player movement (still spaghet)

extends KinematicBody2D

onready var sprite = $PlayerSprite
onready var sprite_ani = $PlayerSprite/SpriteAnimation
onready var collision = $CollisionShape2D

var walk_speed = 60
var jump_speed = 2.5
var y_velocity = 0
var touching_ground = false
var touching_ceiling = false
var land_cooldown

var jump_timer = 0

var gravity = 0.1

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
		front_vec+Vector2(0, 12.15),
		[self],
		1
	)
	var back_vec = global_position+Vector2(-collision.shape.extents.x+collision.position.x, 0)
	var back_raycast = space_state.intersect_ray(
		back_vec,
		back_vec+Vector2(0, 12.15),
		[self],
		1
	)
	touching_ground = front_raycast.size() > 0 or back_raycast.size() > 0
	
	# raycast for ceiling
	front_raycast = space_state.intersect_ray(
		front_vec,
		front_vec+Vector2(0, -10),
		[self],
		1
	)
	back_raycast = space_state.intersect_ray(
		back_vec,
		back_vec+Vector2(0, -10),
		[self],
		1
	)
	touching_ceiling = front_raycast.size() > 0 or back_raycast.size() > 0
	
	# apply physics
	move_and_collide(Vector2(0, y_velocity))
	
	if touching_ground:
		y_velocity = 0
	else:
		y_velocity += gravity
	
	if touching_ceiling and y_velocity < 0:
		y_velocity = 1
	
	# pixel perfect?
	#sprite.global_position = Vector2(int(global_position.x), int(global_position.y))

func _process(delta):
	
	# cool downs
	if land_cooldown >= 0:
		land_cooldown -= delta
	
	handle_controls()
	handle_animation()
	
func handle_controls():
	
	if not GameManager.game_state == GameManager.GameState.GAME:
		return
	
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
	
	# variable jump
	if Input.is_action_pressed("jump"):
		gravity -= 0.01
		gravity = clamp(gravity, 0.05, 0.1)
	if Input.is_action_just_released("jump") or y_velocity > 0:
		gravity = 0.1
	

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
