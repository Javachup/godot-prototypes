class_name ScoreManager
extends Node2D

var _combo := 0

func note_hit():
	_combo += 1
	print(_combo)

func note_missed():
	_combo = 0
	print(_combo)
