extends Node2D

@onready var conductor = %Conductor
@onready var track = $Track

@export var song:Song

func _ready():
	conductor.add_predict_beat(track.spawn_note, 2)
	conductor.start_song(song)

func _on_conductor_on_beat(_position):
	(track.get_child(0).get_child(0) as Sprite2D).modulate = Color.AQUA
