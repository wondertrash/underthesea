extends Sprite2D
@onready var lotus_sprout_anim: AnimationPlayer = $AnimationPlayer
var inventory = {
	"fish": 0,
	"jellyfish": 0,
	"turtle": 0
}
var current_bait: String = "none"
var lifetime_turtles = 0
func _ready() -> void:
	lotus_sprout_anim.play("grow")
func _process(delta: float) -> void:
	pass
