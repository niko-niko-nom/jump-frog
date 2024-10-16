class_name PlayerInput
extends Node

@export var character : PlatformerCharacter2D
@export var actions : PlayerInputActions

var current_delta: float = 0.0

func _physics_process(delta: float) -> void:
	current_delta = delta
	
# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	character.direction = Input.get_vector(actions.left, actions.right, actions.up, actions.down)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(actions.jump):
		character.try_jump(current_delta)
