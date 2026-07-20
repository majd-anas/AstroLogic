extends Node2D
@onready var buttons = $Panel2/Panel/GridContainer.get_children()
const empty=" "
const X="X"
const O="O"
var current_player
var board
@onready var fountain: AnimatableBody2D = $"../../Fountain"
@onready var timer: Timer = $"../../Timer"
@onready var grid: GridContainer = $Panel2/Panel/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button_index =0
	for button in buttons:
		button.connect("pressed",_on_button_click.bind(button_index, button))
		button_index+=1
	reset_game()
func _on_button_click(idx, button):
	var y = idx / 3
	var x = idx % 3
	
	# Using board[y][x] fixes row/column swapping bugs
	if board[y][x] == empty:
		button.text = current_player
		board[y][x] = current_player
		button.disabled = true # Move this up here so it disables immediately
		
		if check_win():
			timer.start()
			fountain.clean()
			print(current_player + " has won")
		elif check_fullboard():
			timer.start()
			print("draw")
		else:
			# Only switch players if the game is continuing
			current_player = X if current_player == O else O


func  check_win():
	for i in range(grid.columns):
		if board[i][0] == board[i][1] and board[i][1] == board[i][2] and board[i][2] !=empty:
			return true
		if board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[2][i] != empty:
			return true
	if board[0][0] == board[1][1] and  board[1][1] == board[2][2] and board[1][1] != empty:
			return true
	if board[2][0] == board[1][1] and  board[1][1]== board[0][2] and  board[1][1] != empty:
			return true

func check_fullboard():
	var board_has_empty_field =false
	for row in board:
		for col in row:
			if col ==empty:
				board_has_empty_field=true
				break
	return not board_has_empty_field

func reset_game():
	current_player = X
	board = [
		[empty,empty,empty],
		[empty,empty,empty],
		[empty,empty,empty],
	]
	# Clear the visual buttons
	if buttons: # Check if buttons array is loaded
		for button in buttons:
			button.text = " "       # Remove the X or O text
			button.disabled = false # Re-enable the button for clicks


func _on_timer_timeout() -> void:
	if check_win():
		hide()
		reset_game()
	if check_fullboard():
		hide()
		reset_game()
	pass # Replace with function body.
