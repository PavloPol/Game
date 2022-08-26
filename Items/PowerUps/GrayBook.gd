extends Item

const AUTO_SHOT: PackedScene = preload("res://Items/PowerUps/SpecialEffects/AutoShot.tscn")

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["special_effects"].append(AUTO_SHOT)
	_player.add_named_effect(AUTO_SHOT)
