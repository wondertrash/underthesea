extends CanvasLayer
@onready var player = get_tree().get_first_node_in_group("resourcestats")
var health_bar: ColorRect
var hunger_bar: ColorRect
var health_bg: ColorRect
var hunger_bg: ColorRect
var time_label: Label
func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	health_bg = ColorRect.new()
	health_bg.position = Vector2(10, 10)
	health_bg.size = Vector2(400, 40)
	health_bg.color = Color(0.067, 0.0, 0.619, 1.0)
	add_child(health_bg)
	health_bar = ColorRect.new()
	health_bar.position = Vector2(10, 10)
	health_bar.size = Vector2(400, 40)
	health_bar.color = Color(0.8, 0.2, 0.2)
	add_child(health_bar)
	hunger_bg = ColorRect.new()
	hunger_bg.position = Vector2(10, 35)
	hunger_bg.size = Vector2(400, 40)
	hunger_bg.color = Color(0.2, 0.2, 0.2)
	add_child(hunger_bg)
	hunger_bar = ColorRect.new()
	hunger_bar.position = Vector2(10, 35)
	hunger_bar.size = Vector2(400, 40)
	hunger_bar.color = Color(0.8, 0.6, 0.2)
	add_child(hunger_bar)
