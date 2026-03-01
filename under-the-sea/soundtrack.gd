extends AudioStreamPlayer
func _ready():
	stream = load("res://Assets/underthesea.wav")
	volume_db = -8
	autoplay = true
	bus = "Music"
	play()
	finished.connect(_on_finished)
func _on_finished():
	play()
