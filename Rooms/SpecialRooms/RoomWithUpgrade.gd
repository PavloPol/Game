extends MyRoom

const ITEMS: Array = [
	preload("res://Items/PowerUps/TrollPU.tscn"),
	preload("res://Items/PowerUps/TornadoPU.tscn"),
	preload("res://Items/PowerUps/RazorBladePU.tscn"),
	preload("res://Items/PowerUps/OrangeSphereFehu.tscn"),
	preload("res://Items/PowerUps/HealthWing.tscn"),
	preload("res://Items/PowerUps/GrayBagPU.tscn"),
	preload("res://Items/PowerUps/GrayBook.tscn"),
	preload("res://Items/PowerUps/PlateArmor.tscn")
]

onready var item_pos: Position2D = get_node("UpgradePos")


func _ready() -> void:
	var item: Area2D = ITEMS[randi() % ITEMS.size()].instance()
	while SavedData.current_items.find(item.name) != -1:
		item = ITEMS[randi() % ITEMS.size()].instance()
	item.position = item_pos.position
	add_child(item)
	
