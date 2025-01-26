class_name HurtComponent
extends Node

@export var stats : StatsComponent
@export var hurtbox : HurtboxComponent

#@onready var audio_player : AudioStreamPlayer3D = $"../../audio/AudioStreamPlayer3D"
@onready var audio_player: AudioStreamPlayer3D = $"../../audio/AudioStreamPlayer3D"




func _ready() -> void:
	hurtbox.hurt.connect(
		func (hitbox : HitboxComponent):
			stats.health -= hitbox.damage
			#print(get_parent().name + "health = " + str(stats.health))
			if audio_player:
				audio_player.stream = preload("res://assets/sound effects/hurt.wav")
				audio_player.play()
			else:
				print("Audio player is null. Cannot play sound.")
	)
