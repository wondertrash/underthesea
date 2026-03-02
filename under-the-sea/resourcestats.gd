extends CanvasLayer
var nutrients_bar: ColorRect
var sunlight_bar: ColorRect
var nutrients_bg: ColorRect
var sunlight_bg: ColorRect
var nutrients: float = 255.0
var sunlight: float = 255.0
var max_value: float = 255.0
var nutrients_drain: float = 2.4
var sunlight_drain: float = 5.6
var game_over: bool = false
func _ready() -> void:
	nutrients_bg = ColorRect.new()
	nutrients_bg.position = Vector2(10, 16)
	nutrients_bg.size = Vector2(360, 24)
	nutrients_bg.color = Color(0.2, 0.2, 0.2)
	add_child(nutrients_bg)
	nutrients_bar = ColorRect.new()
	nutrients_bar.position = Vector2(10, 16)
	nutrients_bar.size = Vector2(360, 24)
	nutrients_bar.color = Color(0.31, 0.78, 0.47)
	add_child(nutrients_bar)
	var nutrients_label = Label.new()
	nutrients_label.text = "Nutrients"
	nutrients_label.position = Vector2(16, 20)
	nutrients_label.add_theme_font_override("font", load("res://Assets/Pixelify_Sans/static/PixelifySans-Regular.ttf"))
	nutrients_label.add_theme_font_size_override("font_size", 14)
	add_child(nutrients_label)
	sunlight_bg = ColorRect.new()
	sunlight_bg.position = Vector2(10, 56)
	sunlight_bg.size = Vector2(360, 24)
	sunlight_bg.color = Color(0.2, 0.2, 0.2)
	add_child(sunlight_bg)
	sunlight_bar = ColorRect.new()
	sunlight_bar.position = Vector2(10, 56)
	sunlight_bar.size = Vector2(360, 24)
	sunlight_bar.color = Color(1, 0.84, 0)
	add_child(sunlight_bar)
	var sunlight_label = Label.new()
	sunlight_label.text = "Light"
	sunlight_label.position = Vector2(16, 60)
	sunlight_label.add_theme_font_override("font", load("res://Assets/Pixelify_Sans/static/PixelifySans-Regular.ttf"))
	sunlight_label.add_theme_font_size_override("font_size", 14)
	add_child(sunlight_label)
func _process(delta: float) -> void:
	if game_over:
		return
	nutrients = max(0.0, nutrients - nutrients_drain * delta)
	sunlight = max(0.0, sunlight - sunlight_drain * delta)
	nutrients_bar.size.x = 360 * (nutrients / max_value)
	sunlight_bar.size.x = 360 * (sunlight / max_value)
	if nutrients <= 0 or sunlight <= 0:
		_trigger_game_over()
func add_nutrients(amount: float) -> void:
	nutrients = min(max_value, nutrients + amount)
func add_sunlight(amount: float) -> void:
	sunlight = min(max_value, sunlight + amount)
func _trigger_game_over() -> void:
	game_over = true
	var player = get_tree().get_first_node_in_group("player")
	var count = player.lifetime_turtles if player else 0
	load("res://gameover.gd").turtle_count = count
	get_tree().change_scene_to_file("res://gameover.tscn")
