class_name DashState
extends State

@onready var enemy_sprite: AnimatedSprite3D = $"../../../EnemySprite"
@onready var player = get_tree().get_first_node_in_group("Player")

@export var actor : CharacterBody3D
@export var path_finder : PathFindComponent
@export var move_component : MovementComponent
@export var stats : StatsComponent

@export var dash_duration : float = 0.5
@export var dash_cooldown : float = 2.5
@export var dash_direction_factor : float = 1.0

var is_dashing : bool = false
var dash_timer : float = 0.0
var dash_cooldown_timer : float = 0.0
var dash_velocity : Vector3 = Vector3.ZERO

func animate():
	if is_dashing:
		if move_component.velocity.x > 0.0:
			enemy_sprite.play("dash_right")
			enemy_sprite.flip_h = false
		if move_component.velocity.x < 0.0:
			enemy_sprite.play("dash_right")
			enemy_sprite.flip_h = true
		if move_component.velocity.z < 0.0 and move_component.velocity.x == 0.0:
			enemy_sprite.play("dash_forward")
		if move_component.velocity.z > 0.0 and move_component.velocity.x == 0.0:
			enemy_sprite.play("dash_down")

func start_dash():
	var dash_direction : Vector3 = path_finder.navigation_agent.target_position - actor.global_transform.origin
	if dash_direction != Vector3.ZERO:
		dash_direction = dash_direction.normalized()
	
	dash_velocity = dash_direction * stats.dash_distance / dash_duration
	is_dashing = true
	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown

func enter() :
	start_dash()
	animate()

func exit() : pass

func update(_delta : float):
	animate()

func physics_update(_delta : float) :
	if is_dashing:
		move_component.velocity = dash_velocity
		dash_timer -= _delta
		if dash_timer <= 0:
			is_dashing = false
			move_component.velocity = Vector3.ZERO
			transitioned.emit(self, "chase")
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= _delta
