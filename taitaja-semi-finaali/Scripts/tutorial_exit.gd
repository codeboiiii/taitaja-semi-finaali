extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_TutorialExit_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	# Start the run timer
	#var run_timer = get_node("/root/Main/UI/RunTimerLabel")
	#if run_timer and run_timer.has_method("start_timer"):
		#run_timer.start_timer()
	#else:
		#push_warning("RunTimerLabel not found or missing start_timer()")
	
	# Activate the hazard
	var hazard = get_node("/root/Main/chasinghazard")
	if hazard and hazard.has_method("start_chase"):
		hazard.start_chase()
	else:
		push_warning("ChasingHazard node not found or missing start_chase()")
	self.monitoring = false
	self.monitorable = false
