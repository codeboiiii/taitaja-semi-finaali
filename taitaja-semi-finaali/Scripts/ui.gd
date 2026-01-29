extends Control
var time
var running
var text
var highscore


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		time += delta
		text = str(int(time))
	#if time > highscore:

			#pass

