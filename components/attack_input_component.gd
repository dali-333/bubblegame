class_name AttackInputComponent
extends Node

@export var stats : StatsComponent
@export var attack_component : bool
@export var hitbox : HitboxComponent

@export var attack_duration : float = 0.5
@export var attack_cooldown : float = 0.4

var is_attacking : bool = false
var attack_timer : float = 0.0
var attack_cooldown_timer : float = 0.0
@onready var attack_box : CollisionShape3D = hitbox.get_child(0)
@onready var attack_base_radius : float = hitbox.get_child(0).shape.radius
var attack_added_radius : float = 0.2;
var special_attack_counter : int = 0
var special_attack_time_limit : float = 2.0
var special_attack_timer : float = 0.0

func attack():
	if attack_box is CollisionShape3D:
		hitbox.monitorable = true
		hitbox.monitoring = true
		is_attacking = true
		attack_timer = attack_duration
		attack_cooldown_timer = attack_cooldown
		special_attack_counter += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") and attack_cooldown_timer <= 0 and not is_attacking:
		attack()

func _process(delta: float) -> void:
	if is_attacking:
		if special_attack_timer < special_attack_time_limit and special_attack_counter == 3:
			attack_box.shape.radius += attack_added_radius * attack_timer * 10
			special_attack_counter = 0
			special_attack_timer = 0.0
		else:
			attack_box.shape.radius += attack_added_radius * attack_timer
			print("Player Attack Radius = " + str(attack_box.shape.radius))
			attack_timer -= delta
			if attack_timer <= 0:
				is_attacking = false
				hitbox.monitorable = false
				hitbox.monitoring = false
				attack_box.shape.radius = attack_base_radius
				print("Player Attack Radius = " + str(attack_box.shape.radius))
	if special_attack_counter >= 1:
		special_attack_timer += delta
	if special_attack_timer >= special_attack_time_limit:
		special_attack_counter = 0
		special_attack_timer = 0
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
