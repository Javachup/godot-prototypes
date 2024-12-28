class_name AnswerManager
extends GridContainer

@export var answers : Array[Answer]

func _unhandled_input(event):
	var reveal = -1
	if   event.is_action_released("Reveal1"): reveal = 1
	elif event.is_action_released("Reveal2"): reveal = 2
	elif event.is_action_released("Reveal3"): reveal = 3
	elif event.is_action_released("Reveal4"): reveal = 4
	elif event.is_action_released("Reveal5"): reveal = 5
	elif event.is_action_released("Reveal6"): reveal = 6
	elif event.is_action_released("Reveal7"): reveal = 7
	elif event.is_action_released("Reveal8"): reveal = 8

	if reveal > 0:
		print(reveal)
		answers[reveal-1].reveal()
