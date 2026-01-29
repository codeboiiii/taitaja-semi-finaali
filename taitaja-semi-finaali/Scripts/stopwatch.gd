extends Node
class_name Stopwatch

var time = 0.0 
var stopped = false
var elapsed_time := 0.0

func _process(delta):
	if stopped:
		return
	time += delta
	
func reset():
	time = 0.0 
	
func time_to_string(time: float) -> String:
	var msec := int(fmod(time, 1.0) * 1000)
	var sec := int(fmod(time, 60))
	var mint := int(time / 60)

	# Formatting: 00:00:000
	return "%02d:%02d:%03d" % [mint, sec, msec]
	
