extends CanvasLayer

onready var labels = ($Labels).get_children()
onready var indicator = $Labels/Indicator

enum ArrowState {
	START,
	HELP,
}
var arrow_state

func _ready():
	arrow_state = ArrowState.START

	for l in labels:
		l.get_font("font").create_from_fnt("res://Font/custom.fnt")

func _process(delta):
	if GameManager.game_state != GameManager.GameState.TITLE:
		return
	
	
	if Input.is_action_just_pressed("ui_up"):
		arrow_state -= 1
	elif Input.is_action_just_pressed("ui_down"):
		arrow_state += 1
	
	arrow_state = clamp(arrow_state, 0, len(ArrowState.values())-1)
	
	if Input.is_action_just_pressed("ui_select"):
		handle_title()
	
	# indicate selected
	indicator.rect_position.y = arrow_state * 20 + 90

func handle_title():
	if arrow_state == ArrowState.START:
		ScreenHandler.ready_to_load = true
		GameManager.start_game()