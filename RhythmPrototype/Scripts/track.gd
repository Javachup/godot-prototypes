class_name Track
extends Path2D

@export var note:PackedScene

var notes:Array[Note] = []

func spawn_note():
	var temp = note.instantiate() as Note
	temp.path_length = curve.get_baked_length()
	notes.append(temp)
	add_child(temp)
