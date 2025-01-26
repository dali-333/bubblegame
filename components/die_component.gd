class_name DieComponent
extends Node

@export var actor : Node3D
@export var stats : StatsComponent
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	stats.no_health.connect(die)

func die() -> void:
	for child1 in player.get_children():
		if child1.name == "Player":
			for child2 in child1.get_children():
				if child2 is ExperienceComponent:
					print("xd")
					var player_exp_component = child2
					player_exp_component.add_experience(stats.xp_gain)
	actor.queue_free()
