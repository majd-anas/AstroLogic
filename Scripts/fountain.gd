extends AnimatableBody2D
@onready var water: AnimatedSprite2D = $AnimatedSprite2D
@onready var window: Control = $CanvasLayer/KM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clean():
	water.play("Clean")
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("hellooooo")
		window.show()
