class_name Answer
extends Control

@onready var real_answer: Label = %"Real Answer"
@onready var real_number: Label = %"Real Number"
@onready var number: Label = %Number
var value: int = 0

@onready var ding = %Ding
@onready var anim = %Anim

var is_real := false
var is_hidden := true

# returns 1 when made revealed, -1 when made hidden, and 0 when it isn't real
func toggle_reveal() -> int:
	if not is_real: return 0

	if is_hidden:
		reveal()
		return 1
	else:
		make_hidden()
		return -1

func reveal():
	if not is_real: return

	anim.play("Reveal")
	ding.play()

	is_hidden = false

func make_hidden():
	anim.play("Hide")

	is_hidden = true

func make_not_real():
	anim.play("NotReal")

func set_answer(answer: String, number: int):
	set_is_real(true)

	value = number
	real_answer.text = answer
	real_number.text = str(number)

func set_is_real(new_is_real: bool):
	if new_is_real:
		make_hidden()
	else:
		make_not_real()
	is_real = new_is_real
