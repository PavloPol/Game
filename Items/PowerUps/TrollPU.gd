extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["player_scale"] += 0.5
	SavedData.current_hero_stats["damage"] += 1
	match SavedData.current_player:
		"Mage":
			SavedData.current_hero_stats["projectile_scale"] += 0.5
