extends Sprite2D
@onready var vines_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	vines_anim.play("vine")
func _process(delta: float) -> void:
	pass
