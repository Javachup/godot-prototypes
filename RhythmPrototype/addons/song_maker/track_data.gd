@tool
class_name TrackData
extends PanelContainer

@onready var beat_container = %BeatContainer

var total_beats:int
var beats_per_measure:int

var beat_checkboxs:Array[CheckBox] = []

var copy_arr:Array[bool] = []

func update_beats():
	for child in beat_container.get_children():
		child.free()
	beat_checkboxs.clear()

	for i in total_beats:
		# Add a separator if it is a new measure (ignore first)
		if i % beats_per_measure == 0:
			if i > 0:
				var line = VSeparator.new()
				beat_container.add_child(line)

			var c_button = Button.new()
			c_button.pressed.connect(func(): copy(i))
			c_button.text = "c"
			beat_container.add_child(c_button)

			var p_button = Button.new()
			p_button.pressed.connect(func(): paste(i))
			p_button.text = "p"
			beat_container.add_child(p_button)

			var label = Label.new()
			label.text = str(i)
			beat_container.add_child(label)

		# Add a checkbox for the beat
		var checkbox = CheckBox.new()
		checkbox.tooltip_text = str(i)
		beat_checkboxs.append(checkbox)
		beat_container.add_child(checkbox)

func copy(pos:int):
	copy_arr.resize(beats_per_measure)
	for i in beats_per_measure:
		copy_arr[i] = beat_checkboxs[pos + i].button_pressed

func paste(pos:int):
	if !copy_arr:
		return

	for i in beats_per_measure:
		beat_checkboxs[pos + i].button_pressed = copy_arr[i]
