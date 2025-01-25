class_name HurtComponent
extends Node

@export var stats : StatsComponent
@export var hurtbox : HurtboxComponent

@onready var audio_player = $"../../Audio/AudioStreamPlayer3D"

func _ready() -> void:
	hurtbox.hurt.connect(
		func (hitbox : HitboxComponent):
			stats.health -= hitbox.damage
			print(get_parent().name + "health = " + str(stats.health))
			audio_player.stream = preload("res://assets/sound effects/hurt.wav")
			audio_player.play()
	)
