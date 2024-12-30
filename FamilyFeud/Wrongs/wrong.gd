class_name Wrong
extends Control

@onready var animation_player = %AnimationPlayer

func make_visible():
	if animation_player.is_playing(): animation_player.stop()
	animation_player.play("ShowWrong")

func make_hidden():
	if animation_player.is_playing(): animation_player.stop()
	visible = false
