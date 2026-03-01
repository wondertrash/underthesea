extends CanvasLayer
@export var events_size: Vector2 = Vector2(420, 640)
@export var events_position: Vector2 = Vector2(1480, 16)
var background = ColorRect
var structure_container = Control
var fish_label: Label
var jellyfish_label: Label
var turtle_label: Label
@onready var player = get_tree().get_first_node_in_group("player")
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
	_add_item("fish", "res://Assets/fish.png", Vector2(0, 0))
	_add_item("jellyfish", "res://Assets/jellyfish.png", Vector2(0, 60))
	_add_item("turtle", "res://Assets/turtle.png", Vector2(0, 120))
func _add_item(item_key: String, texture_path: String, offset: Vector2) -> void:
	var base_pos = events_position + offset
	var img = TextureRect.new()
	img.texture = load(texture_path)
	img.position = base_pos
	img.size = Vector2(80, 80)
	img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	add_child(img)
	var label = Label.new()
	label.add_theme_font_size_override("font_size", 24)
	label.position = base_pos + Vector2(100, 24)
	label.text = "0"
	add_child(label)
	match item_key:
		"fish": fish_label = label
		"jellyfish": jellyfish_label = label
		"turtle": turtle_label = label
func _process(_delta: float) -> void:
	if player and player.get_script() != null and "inventory" in player:
		fish_label.text = str(player.inventory["fish"])
		jellyfish_label.text = str(player.inventory["jellyfish"])
		turtle_label.text = str(player.inventory["turtle"])
