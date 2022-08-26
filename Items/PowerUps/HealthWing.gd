extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["max_hp"] += 3
	SavedData.current_hero_stats["hp"] += 3
