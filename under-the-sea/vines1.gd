extends Sprite2D
@onready var vines1_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	vines1_anim.play("vine1")
func _process(delta: float) -> void:
	pass
