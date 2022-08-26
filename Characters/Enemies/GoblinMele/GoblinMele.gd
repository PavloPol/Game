extends Enemy

onready var attack_timer: Timer = get_node("AttackTimer")
onready var knife_hitbox: Hitbox = get_node("Knife/Sprite/KnifeHitbox")
onready var knife: Node2D = get_node("Knife")

const MAX_DISTANCE_TO_PLAYER: int = 80
const MIN_DISTANCE_TO_PLAYER: int = 40

var distance_to_player: float

func _ready() -> void:
	can_attack = false
	knife.modulate.a = 0.5

func _process(_delta: float) -> void:
	if is_instance_valid(player):
		knife.rotation = (player.position - global_position).normalized().angle() + PI/4


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		if state_machine.state == state_machine.states.attack:
			_get_path_to_player()
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


func after_attack_passed() -> void:
	can_attack = false
	knife.modulate.a = 0.5
	knife_hitbox.set_collision_mask_bit(1, false)
	attack_timer.start()


func death() -> void:
	attack_timer.stop()
	knife.modulate.a = 0.5
	knife_hitbox.set_collision_mask_bit(1, false)


func _on_AttackTimer_timeout() -> void:
	can_attack = true
	knife_hitbox.set_collision_mask_bit(1, true)
	knife.modulate.a = 1


func _on_Hitbox_attack_passed() -> void:
	can_attack = false

