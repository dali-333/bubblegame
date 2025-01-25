class_name DieComponent
extends Node

@export var actor : Node3D
@export var stats : StatsComponent

func _ready() -> void:
	stats.no_health.connect(die)

func die() -> void:
	actor.queue_free()
