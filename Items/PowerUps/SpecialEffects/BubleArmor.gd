extends Sprite

onready var cooldown: Timer = get_node("Cooldown")
onready var collision_shape: CollisionShape2D = get_node("Area2D/CollisionShape2D")

var knockback_direction : Vector2
var knockback_force : int = 600

func start_cooldown() -> void:
	visible = false
	collision_shape.set_deferred("disabled", true)
	cooldown.start()


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		knockback_direction = (area.global_position - global_position).normalized()
		match area.name:
			"ThrowableKnife": 
				area.queue_free()
				start_cooldown()
			"SlimeHitbox":
				get_parent().get_parent().velocity = knockback_direction * knockback_force * -2
				start_cooldown()
			"KnifeHitbox":
				area.emit_signal("attack_passed")
				start_cooldown()
			"FlyingEyeHitbox":
				area.get_parent().velocity = knockback_direction * knockback_force
				start_cooldown()
			"Spikes":
				get_parent().get_parent().velocity = knockback_direction * knockback_force * -1
				start_cooldown()


func _on_Cooldown_timeout() -> void:
	visible = true
	collision_shape.set_deferred("disabled", false)
