extends Player

const FIREBALL_SCENE: PackedScene = preload("res://Characters/Players/Mage/Fireball.tscn")

export(int) var projectile_speed: int = 150
export(int) var projectile_knockback: int = 150
export(float) var projectile_scale : float = 1

func _throw_fireball() -> void:
	var projectile: Hitbox = FIREBALL_SCENE.instance()
	projectile.scale.x = projectile_scale
	projectile.scale.y = projectile_scale
	projectile.launch(global_position, (get_global_mouse_position() - global_position).normalized(), projectile_speed, hero_damage, projectile_knockback)
	get_tree().current_scene.add_child(projectile)


func restore_previous_state() -> void:
	.restore_previous_state()
	projectile_scale = SavedData.current_hero_stats["projectile_scale"]
	weapon_animation_player.playback_speed = SavedData.current_hero_stats["attack_animation_speed"]
	projectile_speed = SavedData.current_hero_stats["projectile_speed"]
	projectile_knockback = SavedData.current_hero_stats["projectile_knockback"]
