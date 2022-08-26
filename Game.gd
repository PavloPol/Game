extends Node2D

onready var players_container: Node2D = get_node("Players")

func _init() -> void:
	randomize()

func _ready() -> void:
	get_node("Players/"+SavedData.current_player+"/Camera2D").current = true
	for player in players_container.get_children():
		if player.name != SavedData.current_player:
			player.queue_free()
		else:
			player.restore_previous_state()
			player.add_special_effect()

