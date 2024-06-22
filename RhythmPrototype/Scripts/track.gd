class_name Track
extends Path2D

@export var note:PackedScene

var notes:Array[Note] = []

func spawn_note():
	var temp = note.instantiate()
	notes.append(temp)
	add_child(temp)
