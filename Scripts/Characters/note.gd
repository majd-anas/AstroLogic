extends StaticBody2D
var player_in_pickup_area=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if player_in_pickup_area && QuestManager.is_quest_active("2"):
			print("picked up")
			queue_free()
			QuestManager.complete_quest("2")
			
		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		player_in_pickup_area=true
		print("player can pick note")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name=="Player":
		player_in_pickup_area=false
		print("player can not pick note")
