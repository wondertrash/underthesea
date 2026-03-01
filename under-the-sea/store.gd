extends CanvasLayer
@onready var player = get_tree().get_first_node_in_group("player")
@export var events_size: Vector2 = Vector2(1080, 340)
@export var events_position: Vector2 = Vector2(384, 670)
var panel: Panel
var background: ColorRect
var structure_container = Control.new()
var recipes = {
	"Standard Bait": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "bait"},
	"Standard Light": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "light"},
	"Standard Fertilizer": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "fertilizer"},
	"Quality Bait": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "bait"},
	"Quality Light": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "light"},
	"Quality Fertilizer": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "fertilizer"},
	"Deluxe Bait": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "bait"},
	"Deluxe Light": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "light"},
	"Deluxe Fertilizer": {"fish": 0, "jellyfish": 0, "turtle": 0, "type": "fertilizer"}
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
	var viewport_size = get_viewport().get_visible_rect().size
	process_mode = Node.PROCESS_MODE_ALWAYS
	panel = Panel.new()
	panel.position = Vector2(viewport_size.x * 0.5 - 576, viewport_size.y * 0.5 + 130)
	panel.size = Vector2(1080, 340)
	panel.visible = true
	panel.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(panel)
	var y_pos = 10
	for item_name in recipes.keys():
		var recipe = recipes[item_name]
		var button = Button.new()
		var costs = []
		if recipe["fish"] > 0: costs.append("F:%d" % recipe["fish"])
		if recipe["jellyfish"] > 0: costs.append("J:%d" % recipe["jellyfish"])
		if recipe["turtle"] > 0: costs.append("T:%d" % recipe["turtle"])
		button.text = "%s (%s)" % [item_name, ", ".join(costs)]
		button.position = Vector2(10, y_pos)
		button.size = Vector2(330, 35)
		button.pressed.connect(_craft_item.bind(item_name))
		panel.add_child(button)
		y_pos += 40
func _craft_item(item_name: String):
	var recipe = recipes[item_name]
	var can_craft = true
	if player.inventory["fish"] < recipe["fish"]: can_craft = false
	if player.inventory["jellyfish"] < recipe["jellyfish"]: can_craft = false
	if player.inventory["turtle"] < recipe["turtle"]: can_craft = false
	if can_craft:
		player.inventory["fish"] -= recipe["fish"]
		player.inventory["jellyfish"] -= recipe["jellyfish"]
		player.inventory["turtle"] -= recipe["turtle"]
		panel.modulate = Color(0.5, 1, 0.5)
		await get_tree().create_timer(0.2).timeout
		panel.modulate = Color(1, 1, 1)
	else:
		panel.modulate = Color(1, 0.5, 0.5)
		await get_tree().create_timer(0.2).timeout
		panel.modulate = Color(1, 1, 1)
