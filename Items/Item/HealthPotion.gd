extends Item

func effect(_player: KinematicBody2D) -> void:
	_player.hp += 10
	SavedData.current_hero_stats["hp"] = _player.hp
