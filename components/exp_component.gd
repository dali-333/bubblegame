class_name ExperienceComponent
extends Node

@export var max_level : int = 10
@export var experience_to_level : float = 100;
@export var current_level : int = 1;
@export var current_experience : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
