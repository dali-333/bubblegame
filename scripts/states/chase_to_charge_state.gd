class_name ChaseToChargeState
extends State

@onready var enemy_sprite: AnimatedSprite3D = $"../../../EnemySprite"

@export var path_finder : PathFindComponent
@export var move_component : MovementComponent
@export var stats : StatsComponent
@export var dash_state : DashState

func animate():
	if move_component.velocity.x > 0.0:
		enemy_sprite.play("move_right")
		enemy_sprite.flip_h = false
	if move_component.velocity.x < 0.0:
		enemy_sprite.play("move_right")
		enemy_sprite.flip_h = true
	if move_component.velocity.z < 0.0 and move_component.velocity.x == 0.0:
		enemy_sprite.play("move_forward")
	if move_component.velocity.z > 0.0 and move_component.velocity.x == 0.0:
		enemy_sprite.play("move_down")

func enter() :
	if (not path_finder.player_in_dash_range()) and (dash_state.dash_timer <= 0):
		path_finder.chase()
		animate()

func exit() : pass

func update(_delta : float):
	if (not path_finder.player_in_dash_range()) and (dash_state.dash_timer <= 0):
		path_finder.chase()
		animate()
	else:
		transitioned.emit(self, "charge")

func physics_update(_delta : float) : pass
