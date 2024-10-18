class_name Player
extends PlatformerCharacter2D

@export_range(0, 100, 1, "or_greater") var move_speed : float = 50.0
@export_range(0, 500, 1, "or_greater") var max_jump_force : float = 100.0
@export_range(0, 1, 1, "or_greater") var min_jump_force : float = 100.0
@export_range(0, 60, .01, "or_greater") var max_jump_charge_time : float = 1.0 #time in seconds

var acceleration : float = 500.0
var deceleration : float = 800.0
var current_speed : float = 0.0

var jump_charge_time : float = 0.0
var is_jumping : bool = false

func _physics_process(delta: float) -> void:
	if not is_jumping:
		_handle_movement(delta)
		_apply_gravity(delta)
		move_and_slide()
	else:
		_jump(delta)

func _handle_movement(delta: float) -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")

	if direction.x != 0:
		# Accelerating
		current_speed = min(current_speed + acceleration * delta, move_speed)
		print("accelerating")
	else:
		# Decelerating
		current_speed = max(current_speed - deceleration * delta, 0)

	# Apply the current speed to the velocity
	velocity.x = current_speed * direction.x

func try_jump(delta: float) -> void:
	if is_on_floor():
		is_jumping = true
		_jump(delta)

func _jump(delta: float):
	if Input.is_action_pressed("jump"):
		print("charging jump")
		jump_charge_time += delta
		jump_charge_time = min(jump_charge_time, max_jump_charge_time)
		
	elif Input.is_action_just_released("jump"):
		print("jump released")
		var jump_force = lerp(min_jump_force, max_jump_force, jump_charge_time / max_jump_charge_time)
		velocity.y = -jump_force
		is_jumping = false
		jump_charge_time = 0
