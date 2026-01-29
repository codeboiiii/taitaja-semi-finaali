extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tutorial_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_node("RunTimerLabel").start_timer()
		get_node("ChasingHazard").set_process(true)
		$TutorialExit.queue_free() # Remove trigger
