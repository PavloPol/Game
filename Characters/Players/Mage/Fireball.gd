extends Hitbox

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var player_exited: bool = false
var direction: Vector2 = Vector2.ZERO
var fireball_speed: int = 0


func _ready() -> void:
	animation_player.play("fly")


func launch(initial_position: Vector2, dir: Vector2, speed: int, hero_damage: int, hero_force: int) -> void:
	damage = hero_damage
	knockback_force = hero_force
	position = initial_position
	direction = dir
	fireball_speed = speed
	rotation += dir.angle() + PI/2 + PI


func _physics_process(delta: float) -> void:
	position += direction * fireball_speed * delta


func _on_Fireball_body_exited(_body: KinematicBody2D) -> void:
	if not player_exited:
		player_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, true)


func _collide(body: KinematicBody2D) -> void:
	if player_exited:
		fireball_speed = 0
		animation_player.play("explosion")
		if body != null:
			knockback_direction = (body.global_position - global_position).normalized()
			body.take_damage(damage, knockback_direction, knockback_force)

