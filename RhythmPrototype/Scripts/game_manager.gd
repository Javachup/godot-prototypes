extends Node2D

@onready var conductor = %Conductor
@onready var track = $Track

@export var song:Song

var temp:Array[Callable] = []
var temp2:Array[float] = [2.0]

func _ready():
	temp.append(track.spawn_note)
	conductor.load_song(song, temp, temp2)
	conductor.start_song()


func _on_track_note_hit(intended_beat):
	print(intended_beat)
