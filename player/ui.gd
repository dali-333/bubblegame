extends Control

@onready var health_bar: ProgressBar = $VBoxContainer/HealthBar
@onready var xp_bar: ProgressBar = $VBoxContainer/XPBar
@onready var shield_cooldown_label: Label = $VBoxContainer/ShieldCooldownLabel
@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var dash_cooldown_label: Label = $VBoxContainer/DashCooldownLabel
@onready var player : CharacterBody3D = self.get_parent()
@export var stats : StatsComponent 
@export var exp : ExperienceComponent
@export var attack : AttackInputComponent
@export var move : MoveInputComponent


func _ready() -> void:
	health_bar.value = stats.health
	xp_bar.value = exp.current_experience
	level_label.text = "Level : " + str(exp.current_level)
	shield_cooldown_label.text = str(round(attack.shield_cooldown_timer))
	dash_cooldown_label.text = str(round(move.dash_cooldown_timer))
	

func _process(delta: float) -> void:
	if xp_bar.value >= xp_bar.max_value:
				xp_bar.min_value = xp_bar.max_value
				xp_bar.max_value = xp_bar.max_value + 100
	health_bar.value = stats.health
	xp_bar.value = exp.current_experience
	level_label.text = "Level : " + str(exp.current_level)
	shield_cooldown_label.text = str(round(attack.shield_cooldown_timer))
	dash_cooldown_label.text = str(round(move.dash_cooldown_timer))
