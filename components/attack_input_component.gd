class_name AttackInputComponent
extends Node

@export var exp_component : ExperienceComponent
@export var stats : StatsComponent
@export var hurtbox : HurtboxComponent
@export var hitbox : HitboxComponent
@export var move_component : MovementComponent
@export var shield : MeshInstance3D
@export var attack_duration : float = 0.5
@export var attack_cooldown : float = 0.4
@export var shield_duration : float = 1.0
@export var shield_cooldown : float = 5.0

@onready var attack_box : CollisionShape3D = hitbox.get_child(0)
@onready var attack_base_radius : float = hitbox.get_child(0).shape.radius
@onready var base_damage = stats.damage
@onready var amp_damage = stats.damage + stats.damage * 0.25
@onready var shield_box : CollisionShape3D = hurtbox.get_child(0)
@onready var shield_shader_material = shield.material as ShaderMaterial

var is_attacking : bool = false
var attack_timer : float = 0.0
var attack_cooldown_timer : float = 0.0
var attack_added_radius : float = 0.2;
var special_attack_counter : int = 0
var special_attack_time_limit : float = 2.0
var special_attack_timer : float = 0.0

var is_shielding : bool = false
var shield_timer : float = 0.0
var shield_cooldown_timer : float = 0.0
var shield_shader_off : float = 0.0


# audio
@onready var audio_player: AudioStreamPlayer3D = $"../../audio/AudioStreamPlayer3D"

func attack():
	if attack_box is CollisionShape3D:
		hitbox.monitorable = true
		hitbox.monitoring = true
		is_attacking = true
		attack_timer = attack_duration
		attack_cooldown_timer = attack_cooldown
		special_attack_counter += 1
		
func play_audio(): 
	if special_attack_counter == 1: 
		audio_player.stream = preload("res://assets/sound effects/aoe_1.wav")
	if special_attack_counter == 2: 
		audio_player.stream = preload("res://assets/sound effects/aoe_2.wav")
	if special_attack_counter == 1: 
		audio_player.stream = preload("res://assets/sound effects/aoe_3.wav")
	audio_player.play()

func handle_attack(_delta):
	if is_attacking:
		if special_attack_timer < special_attack_time_limit and special_attack_counter == 3:
			stats.damage = amp_damage
			attack_box.shape.radius += attack_added_radius * attack_timer * 7.5
			shield.mesh.radius += attack_added_radius * attack_timer * 3.75
			shield.mesh.height += attack_added_radius * attack_timer * 7.5
			special_attack_counter = 0
			special_attack_timer = 0.0
		else:
			stats.damage = base_damage
			attack_box.shape.radius += attack_added_radius * attack_timer * 2
			shield.mesh.radius += attack_added_radius * attack_timer * 0.75
			shield.mesh.height += attack_added_radius * attack_timer * 1.5
			attack_timer -= _delta
			if attack_timer <= 0:
				is_attacking = false
				hitbox.monitorable = false
				hitbox.monitoring = false
				attack_box.shape.radius = attack_base_radius
				shield.mesh.radius = 1.25
				shield.mesh.height = 2.5
	if special_attack_counter >= 1:
		special_attack_timer += _delta
	if special_attack_timer >= special_attack_time_limit:
		special_attack_counter = 0
		special_attack_timer = 0
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= _delta

func shielding():
	if shield_box is CollisionShape3D:
		hurtbox.is_invincible = true
		is_shielding = true
		shield_timer = shield_duration
		shield_cooldown_timer = shield_cooldown

func handle_shield(_delta):
	if is_shielding:
		move_component.velocity = Vector3.ZERO
		shield_shader_off = 0.0
		shield_timer -= _delta
		shield_shader_material.set_shader_parameter("_percentage_border", 1.5 * (shield_duration - shield_timer + 0.5))
		if shield_timer <= 0:
			is_shielding = false
			hurtbox.is_invincible = false
	if not is_shielding:
		if shield_shader_off < 2.25:
			shield_shader_off += _delta
		if shield_shader_off > 1:
			shield_shader_material.set_shader_parameter("_percentage_border", 2.25 - shield_shader_off)
		if shield_shader_off > 2.25:
			shield_shader_material.set_shader_parameter("_percentage_border", 0)
	
	if shield_cooldown_timer > 0:
		shield_cooldown_timer -= _delta


func _ready() -> void:
	exp_component.level_up.connect(
		func():
			base_damage = stats.damage
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") and attack_cooldown_timer <= 0 and not is_attacking:
		attack()
		play_audio()
	
	if event.is_action_pressed("shield") and shield_cooldown_timer <= 0 and not is_shielding:
		shielding()

func _process(delta: float) -> void:
	handle_attack(delta)
	handle_shield(delta)
