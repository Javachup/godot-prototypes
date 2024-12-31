class_name EverythingManager
extends Control

@onready var answer_manager = %AnswerManager
@onready var fast_money_manager = %FastMoneyManager

var is_fast_money := false

func _input(event):
	if event.is_action_pressed("SwapMode"):
		is_fast_money = !is_fast_money

		answer_manager.visible = !is_fast_money
		fast_money_manager.visible = is_fast_money

		if is_fast_money:
			fast_money_manager.clear()
		else:
			answer_manager.load_question()
