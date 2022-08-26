extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["damage"] += 1
	match SavedData.current_player:
		"Mage":
			SavedData.current_hero_stats["projectile_knockback"] += 100
			SavedData.current_hero_stats["projectile_speed"] += 100
		"Knight":
			SavedData.current_hero_stats["sword_knockback"] += 150
		"Shieldman":
			SavedData.current_hero_stats["spear_knockback"] += 150

