class_name MoveInputComponent
extends Node

@onready var player_sprite: AnimatedSprite3D = $"../PlayerBody/PlayerSprite"

@export_group("Related Components")
@export var stats_component : StatsComponent
@export var move_component : MovementComponent

# Dash Exports
@export_group("Dash")
@export var dash_duration : float = 0.3
@export var dash_cooldown : float = 2.5
@export var dash_direction_factor : float = 1.0

# Dash Input
var is_dashing : bool = false
var dash_timer : float = 0.0
var dash_cooldown_timer : float = 0.0
var dash_velocity : Vector3 = Vector3.ZERO

func start_dash():
	var dash_direction : Vector3 = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		dash_direction += -move_component.actor.transform.basis.z
	if Input.is_action_pressed("move_back"):
		dash_direction += move_component.actor.transform.basis.z
	if Input.is_action_pressed("move_left"):
		dash_direction += -move_component.actor.transform.basis.x
	if Input.is_action_pressed("move_right"):
		dash_direction += move_component.actor.transform.basis.x
	if dash_direction != Vector3.ZERO:
		dash_direction = dash_direction.normalized()

	
	dash_velocity = dash_direction * stats_component.dash_distance / dash_duration
	is_dashing = true
	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown

func animate():
	if move_component.velocity == Vector3.ZERO:
			player_sprite.play("idle")
			#if player_sprite.animation == "idle" and player_sprite.animation_finished:
			#	player_sprite.play_backwards("idle")
	if move_component.velocity.x > 0.0:
		player_sprite.play("move_right")
		player_sprite.flip_h = false
	if move_component.velocity.x < 0.0:
		player_sprite.play("move_right")
		player_sprite.flip_h = true
	if move_component.velocity.z < 0.0 and move_component.velocity.x == 0.0:
		player_sprite.play("move_forward")
	if move_component.velocity.z > 0.0 and move_component.velocity.x == 0.0:
		player_sprite.play("move_down")
	if is_dashing:
		if move_component.velocity.x > 0.0:
			player_sprite.play("dash_right")
			player_sprite.flip_h = false
		if move_component.velocity.x < 0.0:
			player_sprite.play("dash_right")
			player_sprite.flip_h = true
		if move_component.velocity.z < 0.0 and move_component.velocity.x == 0.0:
			player_sprite.play("dash_forward")
		if move_component.velocity.z > 0.0 and move_component.velocity.x == 0.0:
			player_sprite.play("dash_down")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and dash_cooldown_timer <= 0 and not is_dashing:
		start_dash()

func _process(delta: float) -> void:
	if player_sprite.animation == "dash_down" or player_sprite.animation == "dash_right" or player_sprite.animation == "dash_forward":
		await get_tree().create_timer(0.3).timeout
		animate()
	else:
		animate()
	animate()

func _physics_process(delta: float) -> void:
	var input_axis : Vector3 = Vector3.ZERO
	input_axis.x = Input.get_axis("move_left", "move_right")
	input_axis.z = Input.get_axis("move_forward", "move_back")
	
	move_component.velocity = input_axis.normalized() * stats_component.move_speed
	
	if is_dashing:
		move_component.velocity = dash_velocity
		dash_timer -= delta
	
		if dash_timer <= 0:
			is_dashing = false
			move_component.velocity = Vector3.ZERO
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
