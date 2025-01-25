class_name HitboxComponent
extends Area3D

@export var stats : StatsComponent
@onready var damage : float = stats.damage

signal hit_hurtbox(hurtbox)

func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox : HurtboxComponent):
	if not hurtbox is HurtboxComponent : return
	if hurtbox.is_invincible : return
	hit_hurtbox.emit(hurtbox)
	hurtbox.hurt.emit(self)
