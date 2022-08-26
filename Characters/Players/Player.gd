extends Character
class_name Player

onready var weapon: Node2D = get_node("Weapon")
onready var weapon_animation_player: AnimationPlayer = weapon.get_node("WeaponAnimationPlayer")
onready var special_effects: Node2D = get_node("SpecialEffects")

export(int) var hero_damage: int = 1

var mouse_direction: Vector2 = Vector2.ZERO

signal max_hp_changed(new)
signal hp_changed(new)
signal game_over()


func _process(_delta: float) -> void:
	mouse_direction = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	weapon.rotation = mouse_direction.angle()


func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		self.hp -= dam
		SavedData.current_hero_stats["hp"] = self.hp
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * 2
			emit_signal("game_over")


func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_just_pressed("ui_attack") and not weapon_animation_player.is_playing() and can_attack:
		attack()
		weapon_animation_player.play("attack")


func attack() -> void:
	pass


func swith_camera() -> void:
	var main_scene_camera: Camera2D = get_parent().get_parent().get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false


func add_special_effect() -> void:
	for i in SavedData.current_hero_stats["special_effects"]:
		self.special_effects.add_child(i.instance())


func add_named_effect(effect: PackedScene) -> void:
	call_deferred("_add_effect_deffered", effect)


func _add_effect_deffered(effect: PackedScene) -> void:
	self.special_effects.add_child(effect.instance())


func restore_previous_state() -> void:
	set_max_hp(SavedData.current_hero_stats["max_hp"])
	set_hp(SavedData.current_hero_stats["hp"])
	hero_damage = SavedData.current_hero_stats["damage"]
	mov_speed = SavedData.current_hero_stats["mov_speed"]
	self.scale.x = SavedData.current_hero_stats["player_scale"]
	self.scale.y = SavedData.current_hero_stats["player_scale"]


func set_hp(new_hp: int) -> void:
# warning-ignore:narrowing_conversion
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", new_hp)


func set_max_hp(new_max_hp: int) -> void:
	max_hp = new_max_hp
	emit_signal("max_hp_changed", new_max_hp)
