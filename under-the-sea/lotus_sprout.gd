extends Sprite2D
@onready var lotus_sprout_anim: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_pressed("grow"):
		lotus_sprout_anim.play("grow")
