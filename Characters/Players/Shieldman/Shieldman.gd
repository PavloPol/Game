extends Player

onready var spear_hitbox: Hitbox = get_node("Weapon/Spear/Sprite/Hitbox")
onready var shield: Node2D = get_node("Weapon/Shield")
onready var shield_cooldown: Timer = get_node("Weapon/Shield/ShieldCooldown")


func _process(_delta: float) -> void:
	._process(_delta)
	spear_hitbox.knockback_direction = mouse_direction
	shield.knockback_direction = mouse_direction


func attack() -> void:
	spear_hitbox.damage = hero_damage


func restore_previous_state() -> void:
	.restore_previous_state()
	shield_cooldown.wait_time = SavedData.current_hero_stats["shield_cooldown"]
	spear_hitbox.knockback_force = SavedData.current_hero_stats["spear_knockback"]
	weapon_animation_player.playback_speed = SavedData.current_hero_stats["attack_animation_speed"]
