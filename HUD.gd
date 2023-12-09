extends CanvasLayer

onready var settings: Popup = get_node("SettingsMenu")
onready var settings_button: Button = get_node("SettingsButton")
onready var start_button: Button = get_node("StartButton")
onready var best_score: Label = get_node("BestScore")
onready var back_ground: ColorRect = get_node("BackGround")
onready var main_game: Node2D = get_node("Game")

export (ButtonGroup) var button_group


func _ready() -> void:
	var best_score_text: String = "Best Scores:\n"
	for i in range(2, -1, -1):
		best_score_text += str(SavedData.best_score[i]) + "\n"
	best_score.text = best_score_text
	main_game.pause_mode = true


func _on_StartButton_pressed() -> void:
	if !settings.visible:
		SavedData.current_player = button_group.get_pressed_button().name
		SavedData.set_hero_stats()
		SceneTransistor.start_transition_to("res://Game.tscn")


func _on_SettingsButton_pressed() -> void:
	settings.visible = true
