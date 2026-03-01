extends CanvasLayer
@onready var player = get_tree().get_first_node_in_group("resourcestats")
var nutrients_bar: ColorRect
var sunlight_bar: ColorRect
var nutrients_bg: ColorRect
var sunlight_bg: ColorRect
var time_label: Label
func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	nutrients_bg = ColorRect.new()
	nutrients_bg.position = Vector2(10, 10)
	nutrients_bg.size = Vector2(360, 30)
	nutrients_bg.color = Color(0.067, 0.0, 0.619, 1.0)
	add_child(nutrients_bg)
	nutrients_bar = ColorRect.new()
	nutrients_bar.position = Vector2(10, 10)
	nutrients_bar.size = Vector2(360, 30)
	nutrients_bar.color = Color(0.8, 0.2, 0.2)
	add_child(nutrients_bar)
	sunlight_bg = ColorRect.new()
	sunlight_bg.position = Vector2(10, 50)
	sunlight_bg.size = Vector2(360, 30)
	sunlight_bg.color = Color(0.2, 0.2, 0.2)
	add_child(sunlight_bg)
	sunlight_bar = ColorRect.new()
	sunlight_bar.position = Vector2(10, 50)
	sunlight_bar.size = Vector2(360, 30)
	sunlight_bar.color = Color(0.8, 0.6, 0.2)
	add_child(sunlight_bar)
