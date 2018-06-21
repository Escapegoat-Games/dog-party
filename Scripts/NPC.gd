# interactable NPC

extends Node2D

onready var sprite_ani = $NPCSprite/SpriteAnimation
onready var interact_area = $InteractArea
onready var icon = $EmoIcon
onready var icon_ani = $EmoIcon/IconAnimation
onready var particles = $Particles2D

export(int) var sprite_id
export(float) var activation_chance
var idle_ani

var is_player_present = false
var is_active = false
var active_time = 0

var player_beg_phase = 0
var player_beg_cooldown = 1

func _ready():
	idle_ani = "Idle_" + id2name(sprite_id)
	icon.hide()
	sprite_ani.play(idle_ani)
	icon_ani.play("Active")

func _process(delta):
	
	# control active icons
	if not is_active && randf() < activation_chance:
		is_active = true
		active_time = rand_range(5, 10)
		icon.show()
	
	if is_active:
		active_time -= delta
		
		# player beg
		if is_player_present:
			if player_beg_phase == 0 && Input.is_action_just_pressed("move_right"):
				player_beg_phase = 1
				player_beg_cooldown = 1
			elif player_beg_phase == 1 && Input.is_action_just_pressed("move_right"):
				# get a point
				player_beg_phase = 1
				GameManager.player_points += 1
				particles.emitting = true
				player_beg_cooldown = 1
				
		if player_beg_cooldown > 0:
			player_beg_cooldown -= delta
		else:
			particles.emitting = false
		
		if active_time <= 0:
			is_active = false
			particles.emitting = false
			icon.hide()

func id2name(id):
	return String(id/10) + String(id%10)

func _on_InteractArea_area_entered(area):
	is_player_present = true

func _on_InteractArea_area_exited(area):
	is_player_present = false
