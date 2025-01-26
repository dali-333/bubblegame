class_name BubbleScore
extends Node

signal bubble_score_changed
@export var score : int = 0:
	set(value):
		score = value
		bubble_score_changed.emit()


func _on_hitbox_component_area_entered(area: Area3D) -> void:
	if area is BubbleFragment:
		score += 1
		area.queue_free()
