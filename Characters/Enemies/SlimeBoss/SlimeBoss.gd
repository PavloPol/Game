extends Enemy

var default_pos: Vector2

func _ready() -> void:
	default_pos = position


func _process(_delta: float) -> void:
	if is_instance_valid(player):
		if player.global_position.y > global_position.y:
			self.z_index = 0
		else:
			self.z_index = 5


func duplicate_slime() -> void:
	if scale > Vector2(1, 1):
		var impulse_direction: Vector2 = Vector2.RIGHT.rotated(rand_range(0, 2*PI))
		_spawn_slime(impulse_direction)
		_spawn_slime(impulse_direction * -1)


func take_damage(dam: int, _dir: Vector2, _force: int) -> void:
	if state_machine.state == state_machine.states.idle:
		self.hp -= dam
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
		else:
			state_machine.set_state(state_machine.states.dead)


func return_pos() -> void:
	position = default_pos


func _spawn_slime(direction: Vector2) -> void:
	var slime: KinematicBody2D = load("res://Characters/Enemies/SlimeBoss/SlimeBoss.tscn").instance()
	slime.position = position + direction * 10
	slime.scale = scale/2
	slime.hp = max_hp/2.0
	slime.max_hp = max_hp/2.0
	get_parent().add_child(slime)
	#slime.velocity += direction * 150
	
