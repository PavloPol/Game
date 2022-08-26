extends CanvasLayer

var new_scene: String

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var text_label: Label = get_node("TextLabel")

onready var background_music: AudioStreamPlayer = get_node("BackgroundMusic")
onready var hit_sound: AudioStreamPlayer = get_node("HitSound")
onready var pick_sound: AudioStreamPlayer = get_node("PickSound")
onready var lose_sound: AudioStreamPlayer = get_node("LoseSound")
onready var win_sound: AudioStreamPlayer = get_node("WinSound")

func _ready():
	set_volume()

func start_transition_to(path_to_scene: String) -> void:
	new_scene = path_to_scene
	animation_player.play("change_scene")
	
	
func change_scene() -> void:
	assert(get_tree().change_scene(new_scene) == OK)

func show_message(message: String) -> void:
	text_label.text = str(message)
	var message_timer = get_tree().create_timer(1.5)
	yield(message_timer, "timeout")
	text_label.text = ""
	SavedData.add_best_score()
	SavedData.reset()
	start_transition_to("res://HUD.tscn")

func play_hit() -> void:
	hit_sound.play()

func play_pick() -> void:
	pick_sound.play()

func play_lose() -> void:
	lose_sound.play()
	
func play_win() -> void:
	win_sound.play()


func set_volume() -> void:
	var effect_volume_db = (SaveSettings.settings["effect_volume"] * (SaveSettings.settings["master_volume"]/100)) - 80
	var music_volume_db = (SaveSettings.settings["music_volume"] * (SaveSettings.settings["master_volume"]/100)) - 80
	hit_sound.volume_db = ((effect_volume_db+80)*0.75)-80
	pick_sound.volume_db = effect_volume_db
	lose_sound.volume_db = effect_volume_db
	win_sound.volume_db = effect_volume_db
	background_music.volume_db = music_volume_db
