extends Node2D
class_name room2

export(int) var room_height: int = 17
export(int) var room_width: int = 30
export(int) var square_nums: int = 5
var max_square_height: int = 0
var max_square_width: int = 0
var room_grid: Array = []
onready var floor_n_wall_tiles: TileMap = get_node("AutoFloorNWall")
onready var border_tiles: TileMap = get_node("AutoBorder")


func _init() -> void:
	randomize()


func _ready() -> void:
# warning-ignore:integer_division
	max_square_height = room_height/3
# warning-ignore:integer_division
	max_square_width = room_width/3
	fill_zeros()
	create_grid()
	
	floor_make()
	wall_make()
	floor_n_wall_tiles.update_bitmask_region()
	border_make()
	border_tiles.update_bitmask_region()
	print_grid()


func create_grid() -> void:
	var position: Vector2 = Vector2(0, 0)
	var square: Vector2 = Vector2(0, 0)
	var i: int = 0
	while(i < square_nums):
		square.x = rand_int(3, max_square_width)
		square.y = rand_int(3, max_square_height)
		if(i == 0):
# warning-ignore:integer_division
			position.x = rand_int(2, room_width/4)
# warning-ignore:integer_division
			position.y = rand_int(2, room_height/4)
			i -= fill_grid(position, square)
			print("Gen "+str(i+1))
		else:
			var border_arr: Array = find_grid_border()
			var rand_coord: int = rand_int(0, border_arr.size()-1)
			position = border_arr[rand_coord]
			i -= fill_grid(position, square)
			print("Gen "+str(i+1))
		i += 1
		
		
#	var i: int = 0
#	while(i < square_nums):
#		square.x = rand_int(2, max_square_width)
#		square.y = rand_int(2, max_square_height)
#		position.x = randi()%(room_width-4-int(square.x))+2
#		position.y = randi()%(room_height-4-int(square.y))+2
#		i -= fill_grid(position, square)
#		i+=1
#		position.x = randi()%int(position.x+square.x)+int((position.x+square.x)*0.75)
#		position.y = randi()%int(position.y+square.y)+int((position.x+square.y)*0.75)


func fill_grid(var start: Vector2, var square: Vector2) -> int:
	if start.x + square.x >= room_grid[0].size() or start.y + square.y >= room_grid.size():
		print("fail")
		return 1
	for i in range(square.y):
		for j in range(square.x):
			room_grid[start.y+i][start.x+j] = 1
	return 0

func floor_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == 1):
				floor_n_wall_tiles.set_cellv(Vector2(j, i), 4)


func wall_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == 1 && room_grid[i-1][j] == 0):
				room_grid[i-1][j] = 2
				floor_n_wall_tiles.set_cellv(Vector2(j, i-1), 3)


func border_make() -> void:
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] == 2):
				room_grid[i-1][j] = 3
				if(room_grid[i][j-1] == 0):
					room_grid[i][j-1] = 3
					room_grid[i-1][j-1] = 3
				if(room_grid[i][j+1] == 0):
					room_grid[i][j+1] = 3
					room_grid[i-1][j+1] = 3
			if(room_grid[i][j] == 1):
				if(room_grid[i][j-1] == 0):
					room_grid[i][j-1] = 3
				if(room_grid[i][j+1] == 0):
					room_grid[i][j+1] = 3
	for i in range(room_height):
		for j in range(room_width):
			if(room_grid[i][j] != 0):
				border_tiles.set_cellv(Vector2(j, i), 1)

func fill_zeros() -> void:
	for i in range(room_height):
		room_grid.append([])
		for _j in range(room_width):
			room_grid[i].append(0)


func find_grid_border() -> Array:
	var border_arr: Array = []
	for j in range(room_width):
		for i in range(room_height-1, -1, -1):
			if(room_grid[i][j] == 1):
				border_arr.append(Vector2(j, i))
				break
	for i in range(room_height):
		for j in range(room_width-1, -1, -1):
			if(room_grid[i][j] == 1):
				border_arr.append(Vector2(j, i))
				break
	return border_arr 

func print_grid() -> void:
	for n in range(room_grid.size()):
		print(room_grid[n])
	print("")

func rand_int(var min_num: int, var max_num: int) -> int:
	var num: int = 0
	num = randi()%(max_num-min_num+1) + min_num
	return num


#export(bool) var boss_room: bool = false
#
#const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/SpawnExplosion.tscn")
#
#const ENEMY_SCENES: Array = [
#	preload("res://Characters/Enemies/FlyingEye/FlyingEye.tscn"),
#	preload("res://Characters/Enemies/GoblinRanged/GoblinRanged.tscn"),
#	preload("res://Characters/Enemies/GoblinMele/GoblinMele.tscn"),
#	preload("res://Characters/Enemies/GoblinBomber/GoblinBomber.tscn")
#]
#
#const BOSS_SCENES: Array = [
#	preload("res://Characters/Enemies/SlimeBoss/SlimeBoss.tscn")
#]
#
#var num_enemies: int
#
#onready var tilemap: TileMap = get_node("TileMap2")
#onready var entrance: Node2D = get_node("Entrance")
#onready var door_container: Node2D = get_node("Doors")
#onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
#onready var player_detector: Area2D = get_node("PlayerDetector")
#
#
#func _ready() -> void:
#	num_enemies = enemy_positions_container.get_child_count()
#
#
#func _on_enemy_killed() -> void:
#	num_enemies -= 1
#	if num_enemies == 0:
#		_open_doors()
#
#
#func _open_doors() -> void:
#	for door in door_container.get_children():
#		door.open()
#
#
#func _close_entrance() -> void:
#	for entry_position in entrance.get_children():
#		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), 2)
#		tilemap.set_cellv(tilemap.world_to_map(entry_position.position) + Vector2.DOWN, 1)
#
#
#func _spawn_enemies() -> void:
#	for enemy_position in enemy_positions_container.get_children():
#		var enemy: KinematicBody2D
#		if boss_room:
#			enemy = BOSS_SCENES[randi() % BOSS_SCENES.size()].instance()
#			num_enemies = 15
#		else:
#			enemy = ENEMY_SCENES[randi() % ENEMY_SCENES.size()].instance()
#
#		enemy.position = enemy_position.position
#		call_deferred("add_child", enemy)
#
#		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
#		spawn_explosion.position = enemy_position.position
#		call_deferred("add_child", spawn_explosion)
#
#
#func _on_PlayerDetector_body_entered(_body: KinematicBody2D) -> void:
#	player_detector.queue_free()
#	if num_enemies > 0:
#		_close_entrance()
#		_spawn_enemies()
#	else:
#		_close_entrance()
#		_open_doors()

