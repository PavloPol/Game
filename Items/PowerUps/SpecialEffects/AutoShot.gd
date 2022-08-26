extends Node2D

const AUTO_KNIFE_SCENE: PackedScene = preload("res://Items/PowerUps/SpecialEffects/AutoKnife.tscn")

onready var cooldown_timer: Timer = get_node("CooldownTimer")

export(int) var projectile_speed: int = 150
export(int) var projectile_number: int = 4

func _ready() -> void:
	randomize()
	cooldown_timer.start()

func _throw_knife(angle: int) -> void:
	var projectile: Area2D = AUTO_KNIFE_SCENE.instance()
	projectile.launch(global_position, Vector2(cos(angle*PI/180), sin(angle*PI/180)), projectile_speed)
	get_tree().current_scene.add_child(projectile)


func _on_CooldownTimer_timeout():
# warning-ignore:integer_division
	var angle = randi()%int(360/projectile_number)
	for i in range(projectile_number):
# warning-ignore:integer_division
		_throw_knife(angle + i*int(360/projectile_number))
	cooldown_timer.start()
