class_name StatsComponent
extends Node

signal health_changed()
signal no_health()

@export var move_speed : float = 20.0
@export var dash_speed : float = 100.0
@export var dash_duration : float = 0.3
@export var dash_cooldown : float = 1.0
@export var health : float = 100.0:
	set(value):
		health = value
		health_changed.emit()
		if health == 0 : no_health.emit()
		
var is_dashing : bool = false
