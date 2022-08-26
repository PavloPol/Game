extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["damage"] += 1
	SavedData.current_hero_stats["attack_animation_speed"] += 0.5

