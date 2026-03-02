extends CanvasLayer
@export var events_size: Vector2 = Vector2(420, 640)
@export var events_position: Vector2 = Vector2(1480, 16)
var background = GradientTexture2D
var font = load("res://Assets/Pixelify_Sans/static/PixelifySans-Regular.ttf")
var structure_container = Control
var fish_label: Label
var jellyfish_label: Label
var turtle_label: Label
@onready var player = get_tree().get_first_node_in_group("player")
func _ready() -> void:
	var grad = Gradient.new()
	grad.set_color(0, Color(0.59, 0.67, 0.83))
	grad.set_color(1, Color(0.3, 0.4, 0.6))
	var grad_tex = GradientTexture2D.new()
	grad_tex.gradient = grad
	grad_tex.fill_from = Vector2(0, 0)
	grad_tex.fill_to = Vector2(0, 1)
	background = TextureRect.new()
	background.position = events_position
	background.size = events_size
	background.texture = grad_tex
	background.stretch_mode = TextureRect.STRETCH_SCALE
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	add_child(background)
	var border = ColorRect.new()
	border.position = events_position - Vector2(2, 2)
	border.size = events_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
	_add_item("fish", "res://Assets/fish.png", Vector2(32, 128))
	_add_item("jellyfish", "res://Assets/jellyfish.png", Vector2(32, 256))
	_add_item("turtle", "res://Assets/turtle.png", Vector2(32, 384))
func _add_item(item_key: String, texture_path: String, offset: Vector2) -> void:
	var base_pos = events_position + offset
	var img = TextureRect.new()
	img.texture = load(texture_path)
	img.position = base_pos
	img.size = Vector2(128, 128)
	img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	add_child(img)
	var label = Label.new()
	label.add_theme_font_override("font", font)
	label.add_theme_font_size_override("font_size", 64)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = base_pos + Vector2(288, 32)
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
