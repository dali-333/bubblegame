class_name Spawns
extends Node3D

@export var spawn_timer : Timer

func _ready() -> void:
	spawn_timer.timeout.connect(
		func():
			var random_spawner = get_random_child(self)
			var spawn_point = random_spawner.global_position
			var instance = random_spawner.instances[randi_range(0, random_spawner.instances.size() - 1)]
			var new_child = instance.instantiate()
			new_child.position = spawn_point
			get_parent().add_child(new_child)
	)

func get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)
