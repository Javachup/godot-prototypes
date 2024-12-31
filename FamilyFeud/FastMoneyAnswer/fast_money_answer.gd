class_name FastMoneyAnswer
extends Control

@onready var line_edit = %LineEdit

func focus():
	line_edit.grab_focus()

func clear():
	line_edit.clear()
