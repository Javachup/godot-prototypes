# Plays the music and emits signals for beats and measures

class_name Conductor
extends AudioStreamPlayer2D

var song:Song :
	set(other):
		if other == null: printerr("Song is null!")
		if other.stream == null: printerr("Stream is null!")
		song = other
		stream = other.stream
		seconds_per_beat = 60.0 / other.bpm

signal on_beat(position)
signal on_measure(position)

var song_time := 0.0
var song_beat_total := 0
var song_beat_measure := 0
var seconds_per_beat := 0.0

var _last_reported_beat := -1

func stop_song():
	song_time = 0.0
	song_beat_total = 0
	song_beat_measure = 0
	stop()

func _physics_process(delta):
	if !playing:
		return

	song_time = get_playback_position() + AudioServer.get_time_since_last_mix() - song.start_delay
	song_time -= AudioServer.get_output_latency()
	song_beat_total = int(floor(song_time / seconds_per_beat))
	song_beat_measure = song_beat_total % song.beats_per_measure

	_report_beat()

func _report_beat():
	if _last_reported_beat < song_beat_total:
		on_beat.emit(song_beat_total)
		on_measure.emit(song_beat_measure)
		_last_reported_beat = song_beat_total
