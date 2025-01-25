class_name ExperienceComponent
extends Node

@export var max_level : int = 10
@export var experience_to_level : float = 100;
@export var current_level : int = 1:
	set(value):
		current_level = value
		level_up.emit()
@export var current_experience : int = 0:
	set(value):
		current_experience = value
		exp_gained.emit()

signal level_up(new_level : int)
signal exp_gained(new_exp : float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
