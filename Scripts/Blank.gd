# Hacky shader fade script

extends Sprite

var time_passed = 0
var scene_removed = false

func _process(delta):
	time_passed += delta
	self.material.set_shader_param("time_passed", time_passed)
	
	if time_passed > 2 and not scene_removed:
		ScreenHandler.free_current_scene()
		scene_removed = true