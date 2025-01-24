class_name MoveInputComponent
extends Node

@export var stats_component : StatsComponent
@export var move_component : MovementComponent

func _physics_process(delta: float) -> void:
	var input_axis : Vector3 = Vector3.ZERO
	input_axis.x = Input.get_axis("move_left", "move_right")
	input_axis.z = Input.get_axis("move_forward", "move_back")
	
	move_component.velocity = input_axis * stats_component.move_speed
