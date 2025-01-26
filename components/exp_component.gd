class_name ExperienceComponent
extends Node

@export var stats : StatsComponent
@export var max_level : int = 10
@export var experience_to_level : float = 80;
@export var current_level : int = 0:
	set(value):
		current_level = value
		level_up.emit(current_level)
@export var current_experience : int = 0:
	set(value):
		current_experience = value
		exp_gained.emit(current_experience)
@export var level_curve : Curve
var sampled_level : float

signal level_up(new_level : int)
signal exp_gained(new_exp : float)

func add_experience(amount : int) -> void:
	current_experience += amount
	while current_experience >= experience_to_level and current_level < max_level:
		current_level += 1
		print("Level Up : " + str(current_level))
		experience_to_level += 100
	
	if current_level == max_level:
		current_experience = min(current_experience, experience_to_level)

func get_progress() -> float:
	return float(current_experience) / experience_to_level * 100

func _ready() -> void:
	level_up.connect(
		func():
			sampled_level = level_curve.sample(current_level / max_level) / 10
			stats.health = 100
			stats.damage += stats.damage * sampled_level
			stats.move_speed += stats.move_speed * sampled_level
			stats.dash_distance += stats.dash_distance * sampled_level
	)
