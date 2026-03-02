extends CanvasLayer
@export var events_size: Vector2 = Vector2(420, 340)
@export var events_position: Vector2 = Vector2(1480, 670)
var background = ColorRect
var font = load("res://Assets/Pixelify_Sans/static/PixelifySans-Regular.ttf")
var structure_container = Control
var bait_label: Label
var bait_pic: TextureRect
@onready var player = get_tree().get_first_node_in_group("player")
func _ready() -> void:
	background = ColorRect.new()
	background.position = events_position
	background.size = events_size
	background.color = Color(0.55, 0.56, 0.69)
	add_child(background)
	var border = ColorRect.new()
	border.position = events_position - Vector2(2, 2)
	border.size = events_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
	var title = Label.new()
	title.text = "Active Bait"
	title.position = events_position + Vector2(80, 20)
	title.add_theme_font_override("font", font)
	title.add_theme_font_size_override("font_size", 48)
	add_child(title)
	bait_label = Label.new()
	bait_label.text = "None"
	bait_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	bait_label.size = Vector2(420, 40)
	bait_label.position = events_position + Vector2(0, 80)
	bait_label.add_theme_font_override("font", font)
	bait_label.add_theme_font_size_override("font_size", 32)
	add_child(bait_label)
	bait_pic = TextureRect.new()
	bait_pic.position = events_position + Vector2(80, 96)
	bait_pic.size = Vector2(256, 256)
	bait_pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	bait_pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	add_child(bait_pic)
func _process(_delta: float) -> void:
	if player:
		match player.current_bait:
			"none":
				bait_label.text = "None"
				bait_pic.texture = load("res://Assets/nonebait.png")
			"standard":
				bait_label.text = "Standard"
				bait_pic.texture = load("res://Assets/standardbait.png")
			"quality":
				bait_label.text = "Quality"
				bait_pic.texture = load("res://Assets/qualitybait.png")
			"deluxe":
				bait_label.text = "Deluxe"
				bait_pic.texture = load("res://Assets/deluxebait.png")
