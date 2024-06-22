class_name Note
extends PathFollow2D

@export_range(0, 10, .1, "or_greater") var time_to_end := 1.0

func _ready():
	var tween:Tween = create_tween()
	tween.tween_property(self, "progress_ratio", 1, time_to_end)
	tween.tween_callback(queue_free)
