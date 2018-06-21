extends Node2D

onready var sprite_ani = $NPCSprite/SpriteAnimation
onready var interact_area = $InteractArea

export(int) var sprite_id
var idle_ani

var is_player_present = false

func _ready():
	idle_ani = "Idle_" + id2name(sprite_id)
	sprite_ani.play(idle_ani)


func id2name(id):
	return String(id/10) + String(id%10)

func _on_InteractArea_area_entered(area):
	is_player_present = true

func _on_InteractArea_area_exited(area):
	is_player_present = false
