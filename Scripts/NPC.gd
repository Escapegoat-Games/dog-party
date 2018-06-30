# interactable NPC

extends Node2D

onready var sprite_ani = $NPCSprite/SpriteAnimation
onready var interact_area = $InteractArea
onready var icon = $EmoIcon
onready var icon_ani = $EmoIcon/IconAnimation
onready var particles = $SparkleParticle
onready var particles2 = $AwwParticle
onready var particles3 = $CuteParticle
onready var particles4 = $HeartParticle

export(int) var sprite_id
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
	icon_ani.play("ActiveLR")
	
	toggle_particles(false)
	randomize()

func _process(delta):
	
	if is_active:
		active_time -= delta
		
		# player beg
		if is_player_present and GameManager.game_state == GameManager.GameState.GAME:
			if player_beg_phase == 0 && Input.is_action_just_pressed("move_right"):
				player_beg_phase = 1
				player_beg_cooldown = 1
			elif player_beg_phase == 1 && Input.is_action_just_pressed("move_right"):
				# get a point
				player_beg_phase = 1
				GameManager.player_points += 1
				toggle_particles(true)
				player_beg_cooldown = 1
				
		if player_beg_cooldown > 0:
			player_beg_cooldown -= delta
		else:
			toggle_particles(false)
		
		if active_time <= 0:
			is_active = false
			toggle_particles(false)
			icon.hide()
			
			get_node("../").activate_npc()

func toggle_particles(b):
	particles.emitting = b
	particles2.emitting = b
	particles3.emitting = b
	particles4.emitting = b

func activate():
	is_active = true
	active_time = rand_range(5, 10)
	icon.show()

func id2name(id):
	return String(id/10) + String(id%10)

func _on_InteractArea_area_entered(area):
	is_player_present = true

func _on_InteractArea_area_exited(area):
	is_player_present = false
