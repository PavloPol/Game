extends Node2D
class_name MyRoom

export(bool) var boss_room: bool = false

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/SpawnExplosion.tscn")

const ENEMY_SCENES: Array = [
	preload("res://Characters/Enemies/FlyingEye/FlyingEye.tscn"),
	preload("res://Characters/Enemies/GoblinRanged/GoblinRanged.tscn"),
	preload("res://Characters/Enemies/GoblinMele/GoblinMele.tscn"),
	preload("res://Characters/Enemies/GoblinBomber/GoblinBomber.tscn")
]

const BOSS_SCENES: Array = [
	preload("res://Characters/Enemies/SlimeBoss/SlimeBoss.tscn")
]

var num_enemies: int

onready var tilemap: TileMap = get_node("TileMap2")
onready var entrance: Node2D = get_node("Entrance")
onready var door_container: Node2D = get_node("Doors")
onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")


func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()


func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()


func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()


func _close_entrance() -> void:
	for entry_position in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), 2)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position) + Vector2.DOWN, 1)


func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy: KinematicBody2D
		if boss_room:
			enemy = BOSS_SCENES[randi() % BOSS_SCENES.size()].instance()
			num_enemies = 15
		else:
			enemy = ENEMY_SCENES[randi() % ENEMY_SCENES.size()].instance()
		
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


func _on_PlayerDetector_body_entered(_body: KinematicBody2D) -> void:
	player_detector.queue_free()
	if num_enemies > 0:
		_close_entrance()
		_spawn_enemies()
	else:
		_close_entrance()
		_open_doors()

