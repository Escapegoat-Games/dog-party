# Manages NPC activation

extends Node2D

var npcs
var is_npc_active = false
var curr_npc_index = 0
var prev_npc_index = 0

func _ready():
	npcs = get_children()
	randomize()
	activate_npc()

func activate_npc():
	
	# keep rolling until get a new index
	prev_npc_index = curr_npc_index
	while curr_npc_index == prev_npc_index:
		curr_npc_index = int(rand_range(0, len(npcs)))
	
	npcs[curr_npc_index].activate()