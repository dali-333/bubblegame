class_name ChaseToAOEState
extends State

@onready var enemy_sprite: AnimatedSprite3D = $"../../../EnemySprite"

@export var path_finder : PathFindComponent
@export var move_component : MovementComponent
@export var stats : StatsComponent
@export var aoe_state : AOEState
@export var aoe_cooldown : float = 5.0;

var aoe_cooldown_timer : float = 0.0


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
	stats.move_speed = 10
	aoe_cooldown_timer = aoe_cooldown
	if aoe_cooldown_timer > 0:
		path_finder.chase()
		animate()

func exit() : pass

func update(_delta : float):
	if aoe_cooldown_timer > 0:
		aoe_cooldown_timer -= _delta;
		path_finder.chase()
		animate()
	else:
		transitioned.emit(self, "aoe")

func physics_update(_delta : float) : pass
