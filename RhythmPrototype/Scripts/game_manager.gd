extends Node2D

@onready var conductor = %Conductor

@export var song:Song

func _ready():
	conductor.song = song
	conductor.playing = true

func _on_conductor_on_beat(position):
	print("beat")
