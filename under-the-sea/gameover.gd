extends Control
static var turtle_count: int = 0
func _ready() -> void:
	$turtleCount.text = "Turtles Caught: %d" % turtle_count
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://lotus.tscn")
func _on_quit_pressed() -> void:
	get_tree().quit()
