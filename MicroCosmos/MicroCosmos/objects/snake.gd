class_name Snake
extends Line2D

@export var snake_length := 10
@export var segment_length := 25.0

func _ready():
	for i in snake_length:
		add_point(Vector2.RIGHT * i * segment_length)


func _process(delta):
	set_point_position(0, get_viewport().get_mouse_position())

	for i in points.size() - 1:
		var new_pos = _constrain_distance(points[i + 1], points[i], segment_length)
		set_point_position(i + 1, new_pos)

func _constrain_distance(point: Vector2, anchor: Vector2, distance: float) -> Vector2:
	return ((point - anchor).normalized() * distance) + anchor
