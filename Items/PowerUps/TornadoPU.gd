extends Item

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["mov_speed"] += 10
	SavedData.current_hero_stats["attack_animation_speed"] += 0.2
