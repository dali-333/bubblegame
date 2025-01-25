class_name PathFindComponent
extends Node

@onready var player = get_tree().get_first_node_in_group("Player")
@export var actor : Node3D
@export var navigation_agent : NavigationAgent3D
@export var movement_component : MovementComponent
@export var stats : StatsComponent
@export var max_dash_range : float = randf_range(20.0, 25.0)
@export var min_dash_range : float = randf_range(10.0, 15.0)

func chase():
	movement_component.velocity = Vector3.ZERO
	navigation_agent.target_position = player.global_transform.origin
	var next_nav_point = navigation_agent.get_next_path_position()
	movement_component.velocity = (next_nav_point - actor.global_transform.origin).normalized() * stats.move_speed
	actor.look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP)

func _process(delta: float) -> void:
	pass

func player_in_dash_range():
	return (actor.global_position.distance_to(player.global_transform.origin) < max_dash_range) and (actor.global_position.distance_to(player.global_transform.origin) > min_dash_range)
