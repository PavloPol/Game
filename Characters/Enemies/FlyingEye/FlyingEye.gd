extends Enemy

onready var hitbox: Area2D = get_node("FlyingEyeHitbox")

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()


