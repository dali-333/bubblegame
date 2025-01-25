class_name HurtboxComponent
extends Area3D

var is_invincible : bool = false:
	set(value):
		is_invincible = value
		for child in get_children():
			if not child is CollisionShape3D and not child is CollisionPolygon3D:
				child.set_deferred("disabled", is_invincible)

signal hurt(hitbox)
