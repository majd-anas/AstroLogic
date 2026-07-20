extends Button
@onready var label: Label = $"../../Label"
var rng = RandomNumberGenerator.new()
func _on_pressed() -> void:
	var LevelsScrean = "res://Scenes/Main/levels.tscn" #LevelsScrean path gose here
	get_tree().change_scene_to_file(LevelsScrean)
	print("Start")
	pass # Replace with function body.
