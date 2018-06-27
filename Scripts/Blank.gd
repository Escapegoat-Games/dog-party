# Hacky shader fade script

extends Sprite

var time_passed = 0

func _process(delta):
	time_passed += delta
	self.material.set_shader_param("time_passed", time_passed)