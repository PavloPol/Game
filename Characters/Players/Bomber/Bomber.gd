extends Player

const BOMB_SCENE: PackedScene = preload("res://Characters/Players/Bomber/Bomb.tscn")

onready var bomb_cooldown: Timer = get_node("Weapon/BombCooldown")

export(float) var explosion_scale : float = 1.5
export(int) var bomb_knockback : int = 300
export(int) var max_num_bomb : int = 2
export(int) var num_bomb : int = 2 setget set_num_bomb


func _place_bomb() -> void:
	var bomb: Node2D = BOMB_SCENE.instance()
	bomb.explosion_scale = explosion_scale
	get_tree().current_scene.add_child(bomb)
	bomb.launch(position, hero_damage, bomb_knockback)


func attack() -> void:
	if num_bomb == 0:
		return
	_place_bomb()
	num_bomb -= 1
	if bomb_cooldown.get_time_left() == 0:
		bomb_cooldown.start()


func _on_BombCooldown_timeout():
	num_bomb += 1
	if num_bomb < max_num_bomb:
		bomb_cooldown.start()


func set_num_bomb(new_num_bomb: int) -> void:
# warning-ignore:narrowing_conversion
	num_bomb = clamp(new_num_bomb, 0, max_num_bomb)


func restore_previous_state() -> void:
	.restore_previous_state()
	explosion_scale = SavedData.current_hero_stats["explosion_scale"]
	max_num_bomb = SavedData.current_hero_stats["max_num_bomb"]
	num_bomb = SavedData.current_hero_stats["max_num_bomb"]
	bomb_knockback = SavedData.current_hero_stats["bomb_knockback"]
	bomb_cooldown.wait_time = SavedData.current_hero_stats["bomb_cooldown"]
