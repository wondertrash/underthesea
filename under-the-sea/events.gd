extends CanvasLayer
@export var events_size: Vector2 = Vector2(1080, 640)
@export var events_position: Vector2 = Vector2(384, 16)
var background = ColorRect
var structure_container = Control
@onready var player = get_tree().get_first_node_in_group("player")
var is_fishing: bool = false
var feedback_label: Label
var fisherman_button: TextureButton
var wave1: TextureRect
var wave2: TextureRect
var bait_rates = {
	"none":     {"fish": 0.60, "jellyfish": 0.10, "turtle": 0.01, "nothing": 0.29},
	"standard": {"fish": 0.58, "jellyfish": 0.18, "turtle": 0.03, "nothing": 0.21},
	"quality":  {"fish": 0.50, "jellyfish": 0.35, "turtle": 0.12, "nothing": 0.03},
	"deluxe":   {"fish": 0.30, "jellyfish": 0.45, "turtle": 0.25, "nothing": 0.00}
}
func _ready() -> void:
	background = ColorRect.new()
	background.position = events_position
	background.size = events_size
	background.color = Color(0.59, 0.67, 0.83)
	add_child(background)
	var border = ColorRect.new()
	border.position = events_position - Vector2(2, 2)
	border.size = events_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
	fisherman_button = TextureButton.new()
	fisherman_button.texture_normal = load("res://Assets/fisherman.png")
	fisherman_button.position = events_position + Vector2(16, 16)
	fisherman_button.size = Vector2(256, 256)
	fisherman_button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	fisherman_button.pressed.connect(_on_fisherman_clicked)
	add_child(fisherman_button)
	wave1 = TextureRect.new()
	wave1.texture = load("res://Assets/wave.png")
	wave1.position = events_position + Vector2(0, 256)
	wave1.size = Vector2(270, 384)
	wave1.stretch_mode = TextureRect.STRETCH_SCALE
	add_child(wave1)
	wave2 = TextureRect.new()
	wave2.texture = load("res://Assets/wave2.png")
	wave2.position = events_position + Vector2(270, 256)
	wave2.size = Vector2(270, 384)
	wave2.stretch_mode = TextureRect.STRETCH_SCALE
	add_child(wave2)
	wave1 = TextureRect.new()
	wave1.texture = load("res://Assets/wave.png")
	wave1.position = events_position + Vector2(540, 256)
	wave1.size = Vector2(270, 384)
	wave1.stretch_mode = TextureRect.STRETCH_SCALE
	add_child(wave1)
	wave2 = TextureRect.new()
	wave2.texture = load("res://Assets/wave2.png")
	wave2.position = events_position + Vector2(810, 256)
	wave2.size = Vector2(270, 384)
	wave2.stretch_mode = TextureRect.STRETCH_SCALE
	add_child(wave2)
	feedback_label = Label.new()
	feedback_label.position = events_position + Vector2(380, 320)
	feedback_label.size = Vector2(300, 40)
	feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	feedback_label.add_theme_font_size_override("font_size", 24)
	feedback_label.text = ""
	add_child(feedback_label)
func _on_fisherman_clicked() -> void:
	if is_fishing:
		return
	is_fishing = true
	fisherman_button.disabled = true
	_do_catch()
func _do_catch() -> void:
	var rates = bait_rates[player.current_bait]
	var roll = randf()
	var result = ""
	if roll < rates["turtle"]:
		result = "turtle"
	elif roll < rates["turtle"] + rates["jellyfish"]:
		result = "jellyfish"
	elif roll < rates["turtle"] + rates["jellyfish"] + rates["fish"]:
		result = "fish"
	else:
		result = "nothing"
	if result == "nothing":
		feedback_label.text = "Nothing..."
	else:
		player.inventory[result] += 1
		if result == "turtle":
			player.lifetime_turtles += 1
		feedback_label.text = "You caught a %s!" % result
	await get_tree().create_timer(2.5).timeout
	feedback_label.text = ""
	is_fishing = false
	fisherman_button.disabled = false
