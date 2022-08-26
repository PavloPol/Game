extends Node2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var bomb_hitbox: Hitbox = get_node("Hitbox")

export(float) var explosion_scale: float = 1.5

func _ready() -> void:
	animation_player.play("explosion")


func set_explosion_scale() -> void:
	self.scale.x = explosion_scale
	self.scale.y = explosion_scale


func launch(bomb_damage: int, bomb_knockback_force: int, initial_position: Vector2) -> void:
	position = initial_position
	bomb_hitbox.damage = bomb_damage
	bomb_hitbox.knockback_force = bomb_knockback_force
