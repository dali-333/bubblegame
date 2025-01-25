class_name HurtComponent
extends Node

@export var stats : StatsComponent
@export var hurtbox : HurtboxComponent

func _ready() -> void:
	hurtbox.hurt.connect(
		func (hitbox : HitboxComponent):
			stats.health -= hitbox.damage
			print(get_parent().name + "health = " + str(stats.health))
	)
