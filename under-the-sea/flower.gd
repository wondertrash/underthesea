extends Sprite2D
@onready var flower_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	flower_anim.play("bloom")
func _process(delta: float) -> void:
	pass
