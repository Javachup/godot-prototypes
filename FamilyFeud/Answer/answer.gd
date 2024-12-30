class_name Answer
extends Control

@onready var reveal_side: Control = %"Reveal Side"
@onready var hidden_side: Control = %"Hidden Side"

@onready var real_answer: Label = %"Real Answer"
@onready var real_number: Label = %"Real Number"
@onready var number: Label = %Number
var value: int = 0

var is_real := false

# returns 1 when made revealed, -1 when made hidden, and 0 when it isn't real
func toggle_reveal() -> int:
	if not is_real: return 0

	if hidden_side.visible:
		reveal()
		return 1
	else:
		make_hidden()
		return -1

func reveal():
	if not is_real: return

	hidden_side.visible = false
	reveal_side.visible = true

func make_hidden():
	hidden_side.visible = true
	reveal_side.visible = false

func make_not_real():
	hidden_side.visible = false
	reveal_side.visible = false

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
