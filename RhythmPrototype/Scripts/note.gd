extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _on_conductor_on_beat(position):
	sprite.frame = 1
	timer.start()

func _on_timer_timeout():
	sprite.frame = 0
