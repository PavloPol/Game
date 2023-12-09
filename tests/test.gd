extends Node2D


onready var floor_n_wall_tiles: TileMap = get_node("AutoFloorNWall")
onready var border_tiles: TileMap = get_node("AutoBorder")
export(int) var room_height: int = 17
export(int) var room_width: int = 30
export(int) var num_iter: int = 4
var room_grid: Array = []


func _init() -> void:
	randomize()


func _ready() -> void:
	fill_zeros()
	create_grid()
	
	printmatr()
	
	floor_make()
	wall_make()
	floor_n_wall_tiles.update_bitmask_region()
	border_make()
	border_tiles.update_bitmask_region()
	
	printmatr()

func create_grid() -> void:
	var x: int = 0
	var y: int = 0
	var area_x: int = int(room_height-6)
	var area_y: int = int(room_width-6)
# warning-ignore:integer_division
# warning-ignore:integer_division
	var square_nums: int = int(area_x*area_y/2/9)
	area_x -= 1
	area_y -= 1
	for _i in range(square_nums):
		x = rand_int(3, area_x)
		y = rand_int(3, area_y)
		for k in range(3):
			for j in range(3):
				room_grid[x+k][y+j] = '#'
	printmatr()
	celluar_automata()


func celluar_automata() -> void:
	for _k in range(num_iter):
		for i in range(2, room_height-2):
			for j in range(2, room_width-2):
				var sum: int = 0
				for i1 in range(-1, 2):
					for j1 in range(-1, 2):
						if(i1 == 0 and j1 == 0):
							continue
						if(room_grid[i+i1][j+j1] == '#' or room_grid[i+i1][j+j1] == '3'):
							sum += 1
				if sum > 2 and room_grid[i][j] == '.':
					room_grid[i][j] = '2'
#				elif (sum < 3 and room_grid[i][j] == '#') or (sum == 8 and room_grid[i][j] == '#'):
#					room_grid[i][j] = '3'
		
		for i in range(1, room_height-1):
			for j in range(1, room_width-1):
				if room_grid[i][j] == '2':
					room_grid[i][j] = '#'
				elif room_grid[i][j] == '3':
					room_grid[i][j] = '.'


func rand_int(var min_num: int, var max_num: int) -> int:
	var num: int = 0
	num = randi()%(max_num-min_num+1) + min_num
	return num


func printmatr() -> void:
	for i in range(room_grid.size()):
		print(room_grid[i])
	print()
	

func fill_zeros() -> void:
	for i in range(room_height):
		room_grid.append([])
		for _j in range(room_width):
			room_grid[i].append('.')

func floor_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == '#'):
				floor_n_wall_tiles.set_cellv(Vector2(j, i), 4)


func wall_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == '#' && room_grid[i-1][j] == '.'):
				room_grid[i-1][j] = '2'
				floor_n_wall_tiles.set_cellv(Vector2(j, i-1), 3)


func border_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == '2'):
				room_grid[i-1][j] = '3'
				if(room_grid[i][j-1] == '.'):
					room_grid[i][j-1] = '3'
					room_grid[i-1][j-1] = '3'
				if(room_grid[i][j+1] == '.'):
					room_grid[i][j+1] = '3'
					room_grid[i-1][j+1] = '3'
			if(room_grid[i][j] == '#'):
				if(room_grid[i][j-1] == '.'):
					room_grid[i][j-1] = '3'
				if(room_grid[i][j+1] == '.'):
					room_grid[i][j+1] = '3'
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] != '.'):
				border_tiles.set_cellv(Vector2(j, i), 1)
