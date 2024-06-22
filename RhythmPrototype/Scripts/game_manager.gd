extends Node2D

@onready var conductor = %Conductor
@onready var track = $Track

@export var song:Song

func _ready():
	conductor.start_song(song)

func _on_conductor_on_beat(_position):
	track.spawn_note()
