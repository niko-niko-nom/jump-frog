class_name Player
extends PlatformerCharacter2D

@export_range(0, 100, 1, "or_greater") var move_speed : float = 50.0
@export_range(0, 500, 1, "or_greater") var max_jump_force : float = 100.0
@export_range(0, 1, 1, "or_greater") var min_jump_force : float = 100.0
@export_range(0, 60, .01, "or_greater") var max_jump_charge_time : float = 1.0 #time in seconds

var jump_charge_time : float = 0.0
var is_jumping : bool = false

func _physics_process(delta: float) -> void:
	velocity.x = move_speed * direction.x
	_apply_gravity(delta)
	
	move_and_slide()
	if is_jumping:
		_jump(delta)

func try_jump(delta: float) -> void:
	if is_on_floor():
		is_jumping = true
		_jump(delta)

func _jump(delta):
		if Input.is_action_pressed("jump"):
			print("charging jump")
			jump_charge_time += delta
			jump_charge_time = min(jump_charge_time, max_jump_charge_time)
			
		elif Input.is_action_just_released("jump"):
			print("jump released")
			var jump_force = lerp(min_jump_force, max_jump_force, jump_charge_time / max_jump_charge_time)
			velocity.y = -jump_force
			is_jumping = false
