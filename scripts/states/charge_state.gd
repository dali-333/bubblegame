class_name ChargeState
extends State

@onready var enemy_sprite: AnimatedSprite3D = $"../../../EnemySprite"

@export var charge_duration : float = 1.25
@export var move_component : MovementComponent
var charge_timer : float = 0.0
var is_charging : bool = false

func enter() :
	move_component.velocity = Vector3.ZERO
	charge_timer = charge_duration
	is_charging = true
	enemy_sprite.play("charge")

func exit() : pass

func update(_delta : float):
	if is_charging:
		charge_timer -= _delta
	if charge_timer <= 0.0 and is_charging:
		transitioned.emit(self, "dash")

func physics_update(_delta : float) : pass
