extends Sprite2D
@onready var vines3_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	vines3_anim.play("vine3")
func _process(delta: float) -> void:
	pass
