extends CanvasLayer

const MIN_HEALTH: int = 23

export (int) var max_hp: int = 4
export (int) var current_hp: int = 4


onready var score_label: Label = get_node("ScoreLabel")
onready var player: KinematicBody2D = get_parent().get_node("Players/"+SavedData.current_player)
onready var health_bar: TextureProgress = get_node("HealthBar")
onready var health_bar_tween: Tween = get_node("HealthBar/Tween")



func _ready() -> void:
	max_hp = player.max_hp
	current_hp = player.hp
	_update_health_bar(100)
	
	
func _update_health_bar(new_value: int) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value, new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()


func _on_Player_hp_changed(new_hp: int) -> void:
	current_hp = new_hp
	var new_health: int  = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)


func _on_Player_max_hp_changed(new_max_hp: int) -> void:
	max_hp = new_max_hp
	var new_max_health: int = int((100 - MIN_HEALTH) * float(current_hp) / new_max_hp) + MIN_HEALTH
	_update_health_bar(new_max_health)


func update_score(new_score) -> void:
	score_label.text = str(new_score)

func _process(_delta: float) -> void:
	update_score(SavedData.score)


func _on_Player_game_over() -> void:
	SceneTransistor.play_lose()
	SceneTransistor.show_message("Game Over")

