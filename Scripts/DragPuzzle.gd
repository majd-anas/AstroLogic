extends GridContainer

# Emit signal when any drag is completed by child cells
signal dragged(from: Vector2i, to: Vector2i)

# 2D array of cells [row] [column]
var _cells: Array = []

func _ready() -> void:
# Initialize _cells array
	for x in columns:
		_cells. append ([])
	var row: int = 0

	var column: int = 0
	for cell in get_children():
		_cells[column].append(cell)
# Tell each cell its grid position
		cell.grid_position = Vector2i(column, row)
# Connect dragged signal
		cell.dragged.connect(dragged.emit)
		column += 1
		if column >= columns:
			column = 0
			row += 1
