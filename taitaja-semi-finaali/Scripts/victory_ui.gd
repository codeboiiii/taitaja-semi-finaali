extends CanvasLayer

@onready var time_label := $TimeLabel
@onready var best_label := $BestTimeLabel

func set_time(time: float):
	if time_label:
		time_label.text = format_time(time)
	var main = get_tree().current_scene
	if best_label and main and main.has_method("load_best_time"):
		best_label.text = "Best: " + format_time(main.load_best_time())

func format_time(t: float) -> String:
	var minutes = int(t / 60)
	var seconds = int(t) % 60
	var millis = int((t - int(t)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, millis]
