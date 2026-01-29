extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var SPEED := 100.0
@export var DASHSPEED := 150.0
const JUMP_VELOCITY = -400.0

var is_wall_grabbing := false
var wall_grab_dir := 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Input_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Input_left", "Input_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		animated_sprite.play("Idle" if direction == 0 else "Move")
	else:
		animated_sprite.play("Jump")

	if direction:
		if Input.is_action_pressed("Input_dash"):
			velocity.x = direction * DASHSPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	# Check for wall collision
	if is_on_wall() and Input.is_action_pressed("Input_jump") == false:
		is_wall_grabbing = true
		animated_sprite.play("Wall_grab")
		wall_grab_dir = sign(get_wall_normal().x)
		velocity.y = 0 # Stick to wall
		
	elif is_wall_grabbing:
		if Input.is_action_just_pressed("Input_jump"):
			velocity.y = JUMP_VELOCITY
			velocity.x = -wall_grab_dir * SPEED * 1.2
			is_wall_grabbing = false
	
func _input(event):
	if event.is_action_pressed("Input_reset_level"):
		get_tree().reload_current_scene()
