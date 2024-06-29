extends Node2D

@onready var label = %Label

const ANIM_LENGTH = 1

func _ready():
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(label, "position", Vector2.UP * 50, ANIM_LENGTH).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).as_relative()
	tween.parallel().tween_property(label, "modulate", modulate * Color.hex(0xFFFFFF00), ANIM_LENGTH)
	tween.tween_callback(queue_free)
