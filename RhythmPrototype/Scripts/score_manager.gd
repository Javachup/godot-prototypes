class_name ScoreManager
extends Node2D

@export var scoring := {0.05: "perfect", 0.1: "great", 0.2: "okay"}
var _combo := 0

func _ready():
	for key in scoring:
		if !(key is float): printerr("Scoring keys must be floats! Key: " + str(key))

func note_hit(intended_time:float, actual_time:float):
	var diff = abs(intended_time - actual_time)
	var eval

	for key in scoring:
		if (diff <= key):
			eval = scoring[key]
			break
	if eval == null:
		note_missed()
		return
	print(eval)

	_combo += 1

func note_missed():
	print("missed")
	_combo = 0
