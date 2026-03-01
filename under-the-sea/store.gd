extends CanvasLayer
@export var events_size: Vector2 = Vector2(1080, 340)
@export var events_position: Vector2 = Vector2(384, 670)
var background = ColorRect
var structure_container = Control
func _ready() -> void:
	background = ColorRect.new()
	background.position = events_position
	background.size = events_size
	background.color = Color(0.1, 0.1, 0.1, 0.8)
	add_child(background)
	var border = ColorRect.new()
	border.position = events_position - Vector2(2, 2)
	border.size = events_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
