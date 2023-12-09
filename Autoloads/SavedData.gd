extends Node

const HERO_STATS : Dictionary = {
	"Knight" : {
		"max_hp" : 4,
		"hp" : 4,
		"player_scale" : 1,
		"damage" : 1,
		"special_effects" : [],
		"mov_speed" : 25,
		"sword_scale" : 1.2,
		"attack_animation_speed" : 1,
		"sword_knockback" : 300
	},
	"Mage" : {
		"max_hp" : 4,
		"hp" : 4,
		"player_scale" : 1,
		"damage" : 1,
		"special_effects" : [],
		"mov_speed" : 20,
		"projectile_scale" : 1,
		"attack_animation_speed" : 0.75,
		"projectile_speed" : 150,
		"projectile_knockback" : 300
	},
	"Shieldman" : {
		"max_hp" : 5,
		"hp" : 5,
		"player_scale" : 1,
		"damage" : 1,
		"special_effects" : [],
		"mov_speed" : 20,
		"shield_cooldown" : 3,
		"spear_knockback" : 150,
		"attack_animation_speed" : 1
	},
	"Assassin" : {
		"max_hp" : 4,
		"hp" : 4,
		"player_scale" : 1,
		"damage" : 2,
		"special_effects" : [],
		"mov_speed" : 25,
		"attack_timer" : 1,
		"daggers_knockback" : 150,
		"dash_power" : 600
	},
	"Bomber" : {
		"max_hp" : 4,
		"hp" : 4,
		"player_scale" : 1,
		"damage" : 1,
		"special_effects" : [],
		"mov_speed" : 20,
		"bomb_cooldown" : 2,
		"bomb_knockback" : 300,
		"max_num_bomb" : 4,
		"explosion_scale" : 2
	}
}

var save_path: String = "user://save.dat"
var best_score: Array = [0, 0, 0]
var num_floor: int = 0
var score: int = 0
var current_player: String = "Knight"
var current_hero_stats: Dictionary = {}
var current_items: Array = []


func _ready() -> void:
	reset()
	set_hero_stats()
	var file = File.new()
	if file.file_exists(save_path):
		var error1 = file.open(save_path, File.READ)
		if error1 == OK:
			best_score = file.get_var()
			file.close()


func set_hero_stats() -> void:
	current_hero_stats = HERO_STATS[current_player].duplicate()


func reset() -> void:
	num_floor = 0
	score = 0
	current_player = "Knight"
	for i in HERO_STATS.keys():
		HERO_STATS[i]["special_effects"] = []
	current_items = []


func add_best_score() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		var error1 = file.open(save_path, File.READ)
		if error1 == OK:
			best_score = file.get_var()
			file.close()
	best_score.sort()
	if score > best_score[0]:
		best_score.pop_front()
		best_score.append(score)
		best_score.sort()
	var error2 = file.open(save_path, File.WRITE)
	if error2 == OK:
		file.store_var(best_score)
		file.close()

