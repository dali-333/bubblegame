class_name AOEState
extends State

@export var path_finder : PathFindComponent
@export var move_component : MovementComponent
@export var stats : StatsComponent
@export var aoe_duration : float = 5.0;
@onready var aoe_attack: Area3D = %AOEAttack
@onready var aoe_damage : float = 5.0
@onready var enemy_sprite: AnimatedSprite3D = $"../../../EnemySprite"

var aoe_timer : float = 0.0

signal aoe_hit_hurtbox(hurtbox)

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

func _on_hurtbox_entered(hurtbox : HurtboxComponent):
	if not hurtbox is HurtboxComponent : return
	if hurtbox.is_invincible : return
	aoe_hit_hurtbox.emit(hurtbox)
	hurtbox.hurt.emit(self)

func enter() :
	aoe_attack.area_entered.connect(_on_hurtbox_entered)
	stats.move_speed = 7.5
	aoe_timer = aoe_duration
	if (aoe_timer > 0.0):
		aoe_attack.monitorable = true
		aoe_attack.monitoring = true
		aoe_attack.get_child(1).visible = true
		path_finder.chase()
		animate()

func exit() :
	aoe_attack.monitorable = false
	aoe_attack.monitoring = false
	aoe_attack.get_child(1).visible = false

func update(_delta : float):
	if (aoe_timer > 0.0):
		aoe_timer -= _delta
		path_finder.chase()
		animate()
	else:
		transitioned.emit(self, "chase")

func physics_update(_delta : float) : pass
