class_name AnswerManager
extends Control

@export var answers : Array[Answer]
@onready var file_dialog = %FileDialog
@onready var score_label = %Score
var score := 0

var last_loaded_path: String

func _ready():
	open_dialog()

func _process(delta):
	score_label.text = str(score)

func _unhandled_input(event):
	if !visible: return

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
		var add = answers[reveal-1].value
		add *= answers[reveal-1].toggle_reveal()
		score += add

	if event.is_action_pressed("HideAll"): load_question(last_loaded_path)
	if event.is_action_pressed("LoadNewQuestion"): open_dialog()

func load_question(file_name: String = ""):
	if file_name.is_empty():
		file_name = last_loaded_path

	if !FileAccess.file_exists(file_name):
		printerr("File " % file_name % "could not be found!")
		return

	var file = FileAccess.open(file_name, FileAccess.READ)

	for i in 8: answers[i].set_is_real(false)

	for i in 8:
		if file.eof_reached(): break

		var line = file.get_csv_line()
		if line.size() != 2:
			printerr("Line " % i % "of question " % file_name % "does not have 2 entries")
			continue

		answers[i].set_answer(line[0], int(line[1]))

	last_loaded_path = file_name
	score = 0

func open_dialog():
	file_dialog.visible = true

func _on_file_dialog_file_selected(path):
	load_question(path)
