extends Sprite2D
@onready var vines2_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	vines2_anim.play("vine2")
func _process(delta: float) -> void:
	pass
