extends Slot

class_name EquiSlot

var default_tex: Texture = preload("res://Assets/UI/Inventory/SlotPlayer.png")

onready var textures: Array = [
	preload("res://Assets/UI/Inventory/Helmet.png"),
	preload("res://Assets/UI/Inventory/BodyArmor.png"),
	preload("res://Assets/UI/Inventory/Weapon.png"),
	preload("res://Assets/UI/Inventory/Ring.png"),
	preload("res://Assets/UI/Inventory/Accessory.png"),
	preload("res://Assets/UI/Inventory/Boots.png"),
]

func _slot_to_str() -> String:
	return ItemUtils.ITEM_TYPES_STR[slot]

func refresh(player_node: Node2D, item_node: Item, added: bool) -> void:
	refresh_style()
	if added:
		player_node.add_equip(item_node, _slot_to_str())
	else:
		player_node.remove_equip(_slot_to_str())
