class_name AnswerManager
extends GridContainer

@export var answers : Array[Answer]

func _ready():
	load_question("res://Questions/TestQuestion.txt")

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
		answers[reveal-1].reveal()

func load_question(file_name: String):
	var file = FileAccess.open(file_name, FileAccess.READ)
	
	for i in 8: answers[i].set_is_real(false)
	
	for i in 8:
		if file.eof_reached(): break

		var line = file.get_csv_line()
		if line.size() != 2:
			printerr("Line " % i % "of question " % file_name % "does not have 2 entries")
			continue

		answers[i].set_answer(line[0], int(line[1]))
