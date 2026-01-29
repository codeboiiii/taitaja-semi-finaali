extends Area2D

@export var boost_speed := 100
@export var boost_duration := 1.5

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.SPEED += boost_speed
		await get_tree().create_timer(boost_duration).timeout
		body.SPEED -= boost_speed
