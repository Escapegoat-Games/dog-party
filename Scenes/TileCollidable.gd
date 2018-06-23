extends StaticBody2D

onready var sprite = $Sprite
onready var collision = $CollisionShape2D

export(bool) var one_way_collidable
export(int) var sprite_id

func _ready():
	sprite.frame = sprite_id
	collision.one_way_collision = one_way_collidable
