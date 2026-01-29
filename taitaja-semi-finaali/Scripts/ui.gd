extends Control
var time
var running
var text
var highscore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		time += delta
		text = str(int(time))
	#if time > highscore:
