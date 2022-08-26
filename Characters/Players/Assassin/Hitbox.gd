extends Hitbox


func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		knockback_direction = (body.global_position - global_position).normalized()
		body.take_damage(damage, knockback_direction, knockback_force)
