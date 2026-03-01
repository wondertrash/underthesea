extends CanvasLayer
@export var lotusbox_size: Vector2 = Vector2(360, 920)
@export var lotusbox_position: Vector2 = Vector2(8, 80)
var background = ColorRect
var structure_container = Control
func _ready() -> void:
	background = ColorRect.new()
	background.position = lotusbox_position
	background.size = lotusbox_size
	background.color = Color(0.78, 0.86, 0.75)
	add_child(background)
	var border = ColorRect.new()
	border.position = lotusbox_position - Vector2(2, 2)
	border.size = lotusbox_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
	structure_container = Control.new()
	structure_container.position = lotusbox_position
	structure_container.size = lotusbox_size
	structure_container.clip_contents = true
	add_child(structure_container)
func _process(_delta):
	var player = get_tree().get_first_node_in_group("player")
	if not player or not is_instance_valid(player):
		visible = false
		return
	else:
		visible = true
