class_name Note
extends PathFollow2D

@export var speed := 200
var time_to_end:float :
	get:
		if path_length < 0: printerr("path_length not set!")
		return path_length / speed
	set(value):
		if path_length < 0: printerr("path_length not set!")
		speed = path_length / value

var path_length:float = -1

func _physics_process(delta):
	progress += speed * delta

	if (progress_ratio >= 1):
		_end_path()

func _end_path():
	queue_free()
