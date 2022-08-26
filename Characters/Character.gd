extends KinematicBody2D
class_name Character

const FRICTION: float = 0.15

export(int) var max_hp: int = 2 setget set_max_hp
export(int) var hp: int = 2 setget set_hp
export(int) var mov_speed: int = 20
export(bool) var flying: bool = false
export(bool) var can_attack: bool = true
export(bool) var can_take_damage: bool = true
export(bool) var can_move: bool = true

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func move() -> void:
	if can_move:
		mov_direction = mov_direction.normalized()
		velocity += mov_direction * mov_speed


func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead and can_take_damage:
		self.hp -= dam
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * 2


func set_hp(new_hp: int) -> void:
# warning-ignore:narrowing_conversion
	hp = clamp(new_hp, 0, max_hp)


func set_max_hp(new_max_hp: int) -> void:
	max_hp = new_max_hp
