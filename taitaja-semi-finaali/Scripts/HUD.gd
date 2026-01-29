extends Control
class_name HUD

@export var stopwatch_label: Label
var stopwatch: Stopwatch

func _ready():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	print(stopwatch) # debug

func _process(delta):
	update_stopwatch_label()

func update_stopwatch_label():
	if stopwatch:
		stopwatch_label.text = stopwatch.time_to_string(stopwatch.elapsed_time)
	
