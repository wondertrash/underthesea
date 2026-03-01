extends Sprite2D
@onready var flower_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	flower_anim.play("wilt")
func _process(delta: float) -> void:
	pass
