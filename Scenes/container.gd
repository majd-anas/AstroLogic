extends Container
@onready var button: Button = $"../Button"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("here",child_entered_tree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
