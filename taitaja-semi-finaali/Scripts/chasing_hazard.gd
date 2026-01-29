extends Area2D

@export var speed_multiplier: float = 1.0
@export var danger_distance: float = 300.0

@export var min_volume: float = -20.0
@export var max_volume: float = 0.0
@export var min_scale: float = 1.0
@export var max_scale: float = 1.3

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player: CharacterBody2D = null
var active: bool = false
var chase_speed: float = 0.0

func _ready():
	# Find the player by group
	player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	if not player:
		push_warning("ChasingHazard could not find Player node!")
	 
	# Disable physics until triggered
	set_physics_process(false)
	
	# Connect collision
	body_entered.connect(_on_body_entered)
	
	# Make sure audio is ready but not playing yet
	if audio:
		audio.stop()

func start_chase():
	if not player:
		# Try finding player again
		player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
		if not player:
			push_warning("ChasingHazard cannot start — Player not found")
			return
		
	active = true
	chase_speed = player.SPEED * speed_multiplier
	set_physics_process(true)
	
	if audio:
		audio.play()

func _physics_process(delta: float) -> void:
	if not active or not player:
		return
	
	# Update speed dynamically
	chase_speed = player.SPEED * speed_multiplier
	
	# Move toward player
	var direction: Vector2 = (player.global_position - global_position).normalized()
	global_position += direction * chase_speed * delta
	
	# Update visual/audio intensity
	update_intensity(global_position.distance_to(player.global_position))
	
func update_intensity(distance: float) -> void:
	var t: float = 1.0 - clamp(distance / danger_distance, 0.0, 1.0)
	
	# Scale sprite
	sprite.scale = Vector2.ONE * lerp(min_scale, max_scale, t)
	
	# Tint sprite color (green -> red)
	sprite.modulate = Color(1.0, 1.0 - t, 1.0 - t)
	
	# Adjust audio
	if audio:
		audio.volume_db = lerp(min_volume, max_volume, t)
		audio.pitch_scale = lerp(0.9, 1.15, t)

func _on_body_entered(body: Node) -> void:
	if not active:
		return
	if body.is_in_group("Player"):
		# Stop the hazard
		active = false
		set_physics_process(false)
		 
		get_tree().current_scene.end_run_gameover()
		# Trigger run end (bullet-time + shake handled in player/camera)
		if body.has_method("on_run_end"):
			body.on_run_end()
		else:
			print("Run end triggered!")
