extends Node2D

onready var cooldown: Timer = get_node("ShieldCooldown")
onready var sprite: Sprite = get_node("Sprite")
onready var collision_shape: CollisionShape2D = get_node("Sprite/Shield/CollisionShape2D")

var knockback_direction : Vector2
var knockback_force : int = 600

func start_cooldown() -> void:
	sprite.modulate.a = 0.5
	collision_shape.set_deferred("disabled", true)
	cooldown.start()

func _on_ShieldCooldown_timeout() -> void:
	sprite.modulate.a = 1
	collision_shape.set_deferred("disabled", false)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		match area.name:
			"ThrowableKnife": 
				area.queue_free()
			"SlimeHitbox":
				get_parent().get_parent().velocity = knockback_direction * knockback_force * -2
			"KnifeHitbox":
				area.emit_signal("attack_passed")
			"FlyingEyeHitbox":
				area.get_parent().velocity = knockback_direction * knockback_force
		start_cooldown()
