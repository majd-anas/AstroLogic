extends StaticBody2D
var in_area=false
signal openKeypadPuzzle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_area and Input.is_action_just_pressed("interact") and QuestManager.is_quest_active("6"):
		emit_signal("openKeypadPuzzle")
		


func _on_key_pad_area_2d_body_entered(body: Node2D) -> void:
	in_area=true

func _on_key_pad_area_2d_body_exited(body: Node2D) -> void:
	in_area=false
