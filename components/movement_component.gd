class_name MovementComponent
extends Node

@export_group("Actor")
@export var actor : Node3D

# Basic Movement
@export_group("Movement")
@export var velocity : Vector3

func _physics_process(delta: float) -> void:
	actor.move_and_collide(velocity * delta)
