extends KinematicBody2D

const UP_DIRECTION := Vector2.UP


export var speed := 600.0

export var jump_strength :=1500.0
export var maximum_jumps := 2
export var double_jump_strength := 1200.0
export var gravity := 4500.0


var _jumps_made := 0
var _velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var _horizontal_direction = (
			Input.get_action_strength("move_right")
			-Input.get_action_strength("move_left")
	)
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta

var is_falling := _velocity.y > 0.0 and not is_on_floor()
var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
var is_double_jumping :=
