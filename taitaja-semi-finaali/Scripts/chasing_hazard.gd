extends Area2D

@export var speed_multiplier := 1.0
@export var danger_distance := 300.0

@export var min_volume := -20.0
@export var max_volume := 0.0

@onready var sprite := $Sprite2D
@onready var audio := $AudioStreamPlayer2D

var player: CharacterBody2D
var chase_speed: float = 0.0

func _ready():
	player = get_tree().get_first_node_in_group("Player") as CharacterBody2D

	if player:
		chase_speed = player.SPEED * speed_multiplier
	else:
		chase_speed = 100.0

	body_entered.connect(_on_body_entered)
	audio.play()


func _physics_process(delta):
	if not player:
		return

	var direction := (player.global_position - global_position).normalized()
	global_position += direction * chase_speed * delta

	update_intensity(global_position.distance_to(player.global_position))

func update_intensity(distance: float):
	var t: float = 1.0 - clamp(distance / danger_distance, 0.0, 1.0)

	sprite.scale = Vector2.ONE * lerp(1.0, 1.3, t)
	sprite.modulate = Color(1.0, 1.0 - t, 1.0 - t)

	audio.volume_db = lerp(min_volume, max_volume, t)
	audio.pitch_scale = lerp(0.9, 1.15, t)

func _on_body_entered(body):
	if body.is_in_group("player"):
		trigger_run_end()

func trigger_run_end():
	var camera := player.get_node_or_null("Camera2D") as Camera2D

	Engine.time_scale = 0.2

	if camera and camera.has_method("start_shake"):
		camera.start_shake()

	await get_tree().create_timer(2.0, true).timeout

	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
