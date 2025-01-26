class_name Collectible
extends Node

@export var stats : StatsComponent
@export var collect_area : Area3D


func _on_bubble_fragment_body_entered(body: Node3D) -> void:
	if body is Player:
		queue_free()
