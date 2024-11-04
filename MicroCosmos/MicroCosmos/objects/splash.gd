class_name Splash
extends Polygon2D

@export var effect_length := 1.0
@export var effect_curve : Curve
@export var rotate_speed := 0.2

var time := 0.0

func _process(delta):
	time += delta / effect_length
	material.set_shader_parameter("effect_amount", effect_curve.sample_baked(time))

	rotate(delta * rotate_speed);

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		splash(get_viewport().get_mouse_position())

func splash(pos: Vector2):
	position = pos
	time = 0
