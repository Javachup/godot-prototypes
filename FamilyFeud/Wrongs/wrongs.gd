class_name Wrongs
extends Control

@export var wrongs: Array[Wrong]
@onready var buzzer = %Buzzer

func _unhandled_input(event):
	if   event.is_action_pressed("Wrong1"): show_wrong(1)
	elif event.is_action_pressed("Wrong2"): show_wrong(2)
	elif event.is_action_pressed("Wrong3"): show_wrong(3)

func show_wrong(num: int):
	if num > 3: num = 3
	if num < 1: return

	for w in wrongs:
		w.make_hidden()

	for i in num:
		wrongs[i].make_visible()

	buzzer.play()
