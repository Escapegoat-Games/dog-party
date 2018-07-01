extends Label

func _ready():
	text = "FINAL SCORE:\n\n\n\n" + GameManager.num2label(GameManager.player_points) + "\n\n\n\n\n\n"
	
	
	if GameManager.player_points > 9999:
		text += "BORKEN"
	elif GameManager.player_points >= 1000:
		text += "Wow..."
	elif GameManager.player_points >= 200:
		text += "GENIUS!"
	elif GameManager.player_points >= 100:
		text += "Pretty cool!"
	elif GameManager.player_points >= 50:
		text += "Nice!"
	elif GameManager.player_points >= 30:
		text += "Great work."
	elif GameManager.player_points >= 10:
		text += "Good try!"
	elif GameManager.player_points == 0:
		text += "Uhhh...hm."
	elif GameManager.player_points < 0:
		text += "Cheater"