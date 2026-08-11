extends Control


@onready var name_label = $NinePatchRect/Label
@onready var text_label = $NinePatchRect/RichTextLabel
@onready var timer: Timer = $Timer
@onready var portrait: TextureRect = $NinePatchRect/Portrait
var current_tween: Tween

func set_text(name, text,charPortrait,duration: float = 1.0):
	if name != "":
		name_label.text = name
	if charPortrait:
		portrait.texture=charPortrait
		portrait.show()
	else:
		portrait.hide()
		
	text_label.text = text
	text_label.visible_ratio = 0.0 # Start empty
	
	current_tween = create_tween()
	current_tween.tween_property(text_label, "visible_ratio", 1.0, duration)

	
	print("Dialogue finished typing!")

	
func _input(event: InputEvent) -> void:
	# Replace "interact" with your exact Input Map action name
	if event.is_action_pressed("interact"):
		# Check if the tween exists and is currently running
		if current_tween and current_tween.is_running():
			current_tween.kill() # Stop the animation
			text_label.visible_ratio = 1.0 # Show everything instantly
			print("Dialogue skipped to end!")


	
