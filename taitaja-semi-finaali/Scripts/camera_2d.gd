extends Camera2D

@export var shake_strength := 12.0
@export var shake_duration := 2.0

var timer: float = 0.0

func start_shake():
	timer = shake_duration

func _process(delta):
	if timer > 0:
		timer -= delta
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO
