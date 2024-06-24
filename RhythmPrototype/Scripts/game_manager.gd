extends Node2D

@onready var conductor = %Conductor
@onready var track = $Track

@export var song:Song

func _ready():
	conductor.add_predict_beat(track.spawn_note, 2)
	conductor.start_song(song)


func _on_track_note_hit(intended_beat):
	print(intended_beat)
