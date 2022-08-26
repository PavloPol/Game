extends Enemy

onready var attack_timer: Timer = get_node("AttackTimer")

const BOMB: PackedScene = preload("res://Characters/Enemies/GoblinBomber/Bomb.tscn")
const MAX_DISTANCE_TO_PLAYER: int = 80
const MIN_DISTANCE_TO_PLAYER: int = 40
const MIN_DISTANCE_TO_ATTACK: int = 20

var distance_to_player: float

func _ready() -> void:
	can_attack = false


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		if can_attack:
			_get_path_to_player()
			if (player.position - global_position).length() < MIN_DISTANCE_TO_ATTACK:
				_place_bomb()
		else:
			distance_to_player = (player.position - global_position).length()
			if distance_to_player > MAX_DISTANCE_TO_PLAYER:
				_get_path_to_player()
			elif distance_to_player < MIN_DISTANCE_TO_PLAYER:
				_get_path_to_move_away_from_player()
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO

func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	path = navigation.get_simple_path(global_position, global_position + dir * 100)


func death() -> void:
	attack_timer.stop()


func _on_AttackTimer_timeout() -> void:
	can_attack = true

func _place_bomb() -> void:
	var bomb: Node2D = BOMB.instance()
	get_parent().add_child(bomb)
	bomb.launch(position)
	can_attack = false
	attack_timer.start()

