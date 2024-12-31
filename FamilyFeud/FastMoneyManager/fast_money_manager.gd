class_name FastMoneyAnswerManager
extends Control

@export var answers_1: Array[FastMoneyAnswer]
@export var scores_1: Array[FastMoneyAnswer]
@export var answers_2: Array[FastMoneyAnswer]
@export var scores_2: Array[FastMoneyAnswer]

@onready var score = %Score

var arrays: Array[Array]

var index := 0
var array := 0

func _ready():
	arrays.append(answers_1)
	arrays.append(scores_1)
	arrays.append(answers_2)
	arrays.append(scores_2)

func _process(_delta):
	score.text = str(sum_scores())

func _input(event):
	if event.is_action_pressed("Up"):
		index = (index - 1) % 5
	elif event.is_action_pressed("Down"):
		index = (index + 1) % 5

	elif event.is_action_pressed("Left"):
		array = (array - 1) % 4
	elif event.is_action_pressed("Right"):
		array = (array + 1) % 4

	arrays[array][index].focus()

func sum_scores() -> int:
	var total := 0
	for s in scores_1:
		total += int(s.line_edit.text)
	for s in scores_2:
		total += int(s.line_edit.text)

	return total

func clear():
	for arr in arrays:
		for i in arr:
			i.clear()
