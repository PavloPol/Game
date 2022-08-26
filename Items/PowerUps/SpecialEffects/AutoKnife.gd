extends Hitbox

var player_exited: bool = false
var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0

func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	knife_speed = speed
	rotation += dir.angle() + PI/4


func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta


func _on_ThrowableKnife_body_exited(_body: KinematicBody2D) -> void:
	if not player_exited:
		player_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, true)


func _collide(body: KinematicBody2D) -> void:
	if player_exited:
		if body != null and body.has_method("take_damage"):
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()
