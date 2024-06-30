@tool
class_name TrackData
extends PanelContainer

@onready var beat_container = %BeatContainer

var total_beats:int
var beats_per_measure:int

var beat_checkboxs:Array[CheckBox]

func update_beats():
	for child in beat_container.get_children():
		child.free()
	beat_checkboxs.clear()

	for i in total_beats:
		# Add a separator if it is a new measure (ignore first)
		if i > 0 and i % beats_per_measure == 0:
			var line = VSeparator.new()
			beat_container.add_child(line)

		# Add a checkbox for the beat
		var checkbox = CheckBox.new()
		beat_checkboxs.append(checkbox)
		beat_container.add_child(checkbox)
