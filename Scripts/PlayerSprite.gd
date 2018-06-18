# Conrols player animation

extends Sprite

onready var sprite_ani = $SpriteAnimation
onready var player = get_node("..")

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_pressed("move_left"):
		flip_h = false
	elif Input.is_action_pressed("move_right"):
		flip_h = true
	
	
	# animation
	if player.state == player.State.IDLE:
		sprite_ani.stop()
		frame = 0
	elif player.state == player.State.WALK and not sprite_ani.is_playing():
		sprite_ani.play("Walking")

