class_name Answer
extends Control

@onready var real_answer = %"Real Answer"
@onready var number = %Number

func reveal():
	number.visible = false
	real_answer.visible = true
