extends HurtComponent

@onready var player_sprite: AnimatedSprite3D = $"../../PlayerSprite"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	hurtbox.hurt.connect(
		func():
			player_sprite.play("hurt")
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
