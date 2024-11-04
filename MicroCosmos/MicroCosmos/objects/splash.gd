class_name Splash
extends Polygon2D

@export var speed := 1.0
@export var curve : Curve

var time := 0.0

func _process(delta):
	time += delta * speed
	material.set_shader_parameter("effect_amount", curve.sample_baked(time))

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		splash(get_viewport().get_mouse_position())

func splash(pos: Vector2):
	position = pos
	time = 0
