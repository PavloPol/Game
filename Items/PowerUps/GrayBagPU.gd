extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.score += 150
	SavedData.current_hero_stats["max_hp"] += 1
	SavedData.current_hero_stats["hp"] += 1

