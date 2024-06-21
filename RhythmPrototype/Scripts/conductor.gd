class_name Conductor
extends AudioStreamPlayer2D

@export var bpm := 100
@export var beats_per_measure := 4
@export var start_delay := 0.0

signal on_beat(position)
signal on_measure(position)

var song_time := 0.0
var song_beat_total := 0
var song_beat_measure := 0
var seconds_per_beat := 60.0 / bpm

var _last_reported_beat := -1

func _ready():
	seconds_per_beat = 60.0 / bpm

func _physics_process(delta):
	if !playing:
		return

	song_time = get_playback_position() + AudioServer.get_time_since_last_mix() - start_delay
	song_time -= AudioServer.get_output_latency()
	song_beat_total = int(floor(song_time / seconds_per_beat))
	song_beat_measure = song_beat_total % beats_per_measure

	_report_beat()

var temp = 0.0
func _report_beat():
	if _last_reported_beat < song_beat_total:
		on_beat.emit(song_beat_total)
		on_measure.emit(song_beat_measure)
		_last_reported_beat = song_beat_total
