extends CanvasLayer
@onready var player = get_tree().get_first_node_in_group("player")
@export var events_size: Vector2 = Vector2(1080, 340)
@export var events_position: Vector2 = Vector2(384, 670)
var panel: Panel
var background: ColorRect
var structure_container = Control.new()
var recipes = {
	"Standard Bait": {"fish": 3, "jellyfish": 0, "turtle": 0, "type": "bait"},
	"Standard Fertilizer": {"fish": 2, "jellyfish": 0, "turtle": 0, "type": "fertilizer"},
	"Standard Light": {"fish": 2, "jellyfish": 0, "turtle": 0, "type": "light"},
	"Quality Bait": {"fish": 2, "jellyfish": 2, "turtle": 0, "type": "bait"},
	"Quality Fertilizer": {"fish": 1, "jellyfish": 2, "turtle": 0, "type": "fertilizer"},
	"Quality Light": {"fish": 1, "jellyfish": 2, "turtle": 0, "type": "light"},
	"Deluxe Bait": {"fish": 3, "jellyfish": 3, "turtle": 1, "type": "bait"},
	"Deluxe Fertilizer": {"fish": 2, "jellyfish": 3, "turtle": 1, "type": "fertilizer"},
	"Deluxe Light": {"fish": 2, "jellyfish": 3, "turtle": 1, "type": "light"}
}
func _ready() -> void:
	background = ColorRect.new()
	background.position = events_position
	background.size = events_size
	background.color = Color(0.78, 0.86, 0.75)
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
	panel.modulate = Color(0.62, 0.76, 0.29)
	panel.visible = true
	panel.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(panel)
	var col = 0
	var row = 0
	var btn_width = 347
	var btn_height = 100
	var padding = 10
	for item_name in recipes.keys():
		var recipe = recipes[item_name]
		var button = Button.new()
		var costs = []
		if recipe["fish"] > 0: costs.append("F:%d" % recipe["fish"])
		if recipe["jellyfish"] > 0: costs.append("J:%d" % recipe["jellyfish"])
		if recipe["turtle"] > 0: costs.append("T:%d" % recipe["turtle"])
		button.text = "%s (%s)" % [item_name, ", ".join(costs)]
		button.position = Vector2(col * (btn_width + padding) + padding, row * (btn_height + padding) + padding)
		button.size = Vector2(btn_width, btn_height)
		button.modulate = Color(1, 1, 1)
		button.pressed.connect(_craft_item.bind(item_name))
		panel.add_child(button)
		col += 1
		if col >= 3:
			col = 0
			row += 1
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
		if recipe["type"] == "bait":
			if item_name.begins_with("Standard"): player.current_bait = "standard"
			elif item_name.begins_with("Quality"): player.current_bait = "quality"
			elif item_name.begins_with("Deluxe"): player.current_bait = "deluxe"
		var stats = get_tree().get_first_node_in_group("resourcestats")
		if stats:
			var tier_bonus = 0.0
			if item_name.begins_with("Standard"): tier_bonus = 64.0
			elif item_name.begins_with("Quality"): tier_bonus = 128.0
			elif item_name.begins_with("Deluxe"): tier_bonus = 192.0
			if recipe["type"] == "fertilizer":
				stats.add_nutrients(tier_bonus)
			elif recipe["type"] == "light":
				stats.add_sunlight(tier_bonus)
		panel.modulate = Color(0.5, 1, 0.5)
		await get_tree().create_timer(0.2).timeout
		panel.modulate = Color(1, 1, 1)
	else:
		panel.modulate = Color(1, 0.5, 0.5)
		await get_tree().create_timer(0.2).timeout
		panel.modulate = Color(1, 1, 1)
