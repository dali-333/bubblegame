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

#variables to control the soundtrack 
#@onready var soundtrack =  $Soundtrack
var max_current_experience = 10 
var min_current_experience = 0
var mid_current_experience = 5 
var max_volume = 0 
var min_volume = -60 




signal level_up(new_level : int)
signal exp_gained(new_exp : float)

func add_experience(amount : int) -> void:
	current_experience += amount
	while current_experience >= experience_to_level and current_level < max_level:
		current_experience -= experience_to_level
		current_level += 1
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
	
func _process(delta: float) -> void:
	print("current experience = ", current_experience)
	if (current_experience >= min_current_experience) and (current_experience < mid_current_experience) :
		print('first')
		Soundtrack.stream.set_sync_stream_volume(1,-60)
		Soundtrack.stream.set_sync_stream_volume(2,-60)
	if (current_experience >= mid_current_experience) and (current_experience < max_current_experience):
		print('second')
		Soundtrack.stream.set_sync_stream_volume(1, current_experience)
		Soundtrack.stream.set_sync_stream_volume(2,min_volume)
	if (current_experience >= max_current_experience):
		print('third')
		Soundtrack.stream.set_sync_stream_volume(1,current_experience)
		Soundtrack.stream.set_sync_stream_volume(2,current_experience)
		
		
	
