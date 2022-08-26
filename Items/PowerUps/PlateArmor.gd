extends Item

const BUBLE_ARMOR: PackedScene = preload("res://Items/PowerUps/SpecialEffects/BubleArmor.tscn")

func effect(_player: KinematicBody2D) -> void:
	SavedData.current_hero_stats["special_effects"].append(BUBLE_ARMOR)
	_player.add_named_effect(BUBLE_ARMOR)
