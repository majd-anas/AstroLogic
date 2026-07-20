extends Panel

var is_open : bool = false

func _ready() -> void:
	close()

func _process(delta) -> void:
	if Input.is_action_just_pressed("g"):
		if is_open:
			close()
		else:
			open()

func close() -> void:
	visible = false
	is_open = false

func open() -> void:
	visible = true
	is_open = true
