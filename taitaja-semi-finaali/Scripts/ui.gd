extends Control
var seconds = 0.0
var minutes = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if seconds >= 60:
		minutes += 1



func _on_timer_timeout() -> void:
	seconds += 1
