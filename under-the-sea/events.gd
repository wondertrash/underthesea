extends CanvasLayer
@export var events_size: Vector2 = Vector2(1080, 640)
@export var events_position: Vector2 = Vector2(384, 16)
var background = ColorRect
var structure_container = Control
@onready var player = get_tree().get_first_node_in_group("player")
var is_fishing: bool = false
var feedback_label: Label
var fisherman_button: Button
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
	background.color = Color(0.1, 0.1, 0.1, 0.8)
	add_child(background)
	var border = ColorRect.new()
	border.position = events_position - Vector2(2, 2)
	border.size = events_size + Vector2(4, 4)
	border.color = Color(0.5, 0.5, 0.5)
	border.z_index = -1
	add_child(border)
	fisherman_button = Button.new()
	fisherman_button.text = "Fisherman"
	fisherman_button.position = events_position + Vector2(400, 250)#change position
	fisherman_button.size = Vector2(150, 60)#change size
	fisherman_button.pressed.connect(_on_fisherman_clicked)
	add_child(fisherman_button)
	feedback_label = Label.new()
	feedback_label.position = events_position + Vector2(370, 320)#change position
	feedback_label.size = Vector2(300, 40)
	feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	feedback_label.add_theme_font_size_override("font_size", 18)
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
		feedback_label.text = "You caught a %s!" % result
	await get_tree().create_timer(3.0).timeout
	feedback_label.text = ""
	is_fishing = false
	fisherman_button.disabled = false
