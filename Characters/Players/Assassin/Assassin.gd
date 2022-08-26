extends Player

onready var daggers_hitbox: Hitbox = get_node("Weapon/Daggers/Sprite/Hitbox")
onready var daggers_sprite: Sprite = get_node("Weapon/Daggers/Sprite")
onready var attack_timer: Timer = get_node("Weapon/AttackTimer")

export(int) var dash_power: int = 600


func _process(_delta: float) -> void:
	._process(_delta)
	if weapon.scale.y == 1 and mouse_direction.x < 0:
		weapon.scale.y = -1
	elif weapon.scale.y == -1 and mouse_direction.x > 0:
		weapon.scale.y = 1
	#daggers_hitbox.knockback_direction = mouse_direction


func attack() -> void:
	daggers_sprite.modulate.a = 0.5
	can_attack = false
	daggers_hitbox.damage = hero_damage
	velocity += mouse_direction * dash_power
	attack_timer.start()


func _on_AttackTimer_timeout():
	daggers_sprite.modulate.a = 1
	can_attack = true


func restore_previous_state() -> void:
	.restore_previous_state()
	daggers_hitbox.knockback_force = SavedData.current_hero_stats["daggers_knockback"]
	attack_timer.wait_time = SavedData.current_hero_stats["attack_timer"]
	dash_power = SavedData.current_hero_stats["dash_power"]

