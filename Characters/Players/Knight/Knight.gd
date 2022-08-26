extends Player

onready var sword_hitbox: Hitbox = get_node("Weapon/Sword/Sprite/Hitbox")


func _process(_delta: float) -> void:
	._process(_delta)
	sword_hitbox.knockback_direction = mouse_direction


func attack() -> void:
	sword_hitbox.damage = hero_damage


func restore_previous_state() -> void:
	.restore_previous_state()
	weapon.scale.x = SavedData.current_hero_stats["sword_scale"]
	weapon.scale.y = SavedData.current_hero_stats["sword_scale"]
	weapon_animation_player.playback_speed = SavedData.current_hero_stats["attack_animation_speed"]
	sword_hitbox.knockback_force = SavedData.current_hero_stats["sword_knockback"]
