class_name StatsComponent
extends Node

@export var exp_component : ExperienceComponent
@export var move_speed : float = 15.0
@export var dash_distance : float = 25.0
@export var damage : float = 1.0
@export var xp_gain : float = 0.0

signal health_changed()
signal no_health()
@export var health : float = 100.0:
	set(value):
		health = value
		health_changed.emit()
		if health == 0 : no_health.emit()
