extends CanvasLayer

@onready var time_label = $TimeLabel

func set_time(time: float):
	time_label.text = format_time(time)

func format_time(t: float) -> String:
	var minutes = int(t / 60)
	var seconds = int(t) % 60
	var millis = int((t - int(t)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, millis]

func _on_retry_pressed():
	get_tree().reload_current_scene()
