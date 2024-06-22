# Plays the music and emits signals for beats and measures

class_name Conductor
extends AudioStreamPlayer2D

@onready var start_timer = %StartTimer

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

var _predicted_beat_list:Array = []

func start_song(songToPlay:Song):
	song = songToPlay

	var earliest_prediction_time := 0.0
	for predicted_beat in _predicted_beat_list:
		if predicted_beat["time"] < earliest_prediction_time:
			earliest_prediction_time = predicted_beat["time"]

	var wait_time = -earliest_prediction_time - song.start_delay
	if wait_time > 0:
		start_timer.wait_time = wait_time
		start_timer.start()
	else:
		playing = true

func _on_start_timer_timeout():
	playing = true

func stop_song():
	song_time = 0.0
	song_beat_total = 0
	song_beat_measure = 0
	stop()

func get_closest_beat() -> int:
	return roundi(song_time / seconds_per_beat)

func get_time_of_beat(beat:int) -> float:
	return beat * seconds_per_beat

# beat_callback is called when there is time_until_beat seconds until a beat
# After beat_callback is called, a beat will happen exactly time_until_beat seconds later
func add_predict_beat(beat_callback:Callable, time_until_beat:float) -> int:
	if playing:
		printerr("Trying to add prediction while playing!")
		return -1
	_predicted_beat_list.append({"time": -time_until_beat, "callback": beat_callback})
	return _predicted_beat_list.size() - 1

func remove_predict_beat(index:int):
	_predicted_beat_list.remove_at(index)

func _physics_process(_delta):
	if !playing:
		if start_timer.is_stopped():
			return
		else:
			song_time = start_timer.time_left - (start_timer.wait_time + song.start_delay)

	# Update song time and beats based on the audio being played
	song_time = get_playback_position() + AudioServer.get_time_since_last_mix() - song.start_delay
	song_time -= AudioServer.get_output_latency()
	song_beat_total = int(floor(song_time / seconds_per_beat))
	song_beat_measure = song_beat_total % song.beats_per_measure

	# Call/Emit based on the time
	_predict_beat()
	_report_beat()

func _report_beat():
	if _last_reported_beat < song_beat_total:
		on_beat.emit(song_beat_total)
		on_measure.emit(song_beat_measure)
		_last_reported_beat = song_beat_total

#
func _predict_beat():
	for predicted_beat in _predicted_beat_list:
		if predicted_beat["time"] < song_time:
			predicted_beat["callback"].call()
			predicted_beat["time"] += seconds_per_beat
