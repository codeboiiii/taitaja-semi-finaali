extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_TutorialExit_body_entered(body: Node2D) -> void:
	print("TutorialExit triggered by: ", body.name)
	if not body.is_in_group("Player"):
		return
	
	# Start the run timer
	get_tree().current_scene.start_run()
	
	# Activate the hazard
	var hazard = get_tree().current_scene.get_node("ChasingHazard") as Area2D
	if hazard and hazard.has_method("start_chase"):
		hazard.start_chase()
	else:
		push_warning("ChasingHazard node not found or missing start_chase()")
	call_deferred("set_deferred_monitoring", false)
	call_deferred("set_deferred_monitorable", false)
	
func set_deferred_monitoring(value: bool):
	monitoring = value

func set_deferred_monitorable(value: bool):
	monitorable = value
