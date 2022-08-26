extends Hitbox

signal attack_passed()


func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		emit_signal("attack_passed")
		body.take_damage(damage, knockback_direction, knockback_force)
