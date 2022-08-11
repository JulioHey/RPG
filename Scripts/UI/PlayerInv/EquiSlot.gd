extends Slot

class_name EquiSlot


var base_str: String = "res://Assets/UI/Inventory/%s.png"

var default_tex: Texture = preload("res://Assets/UI/Inventory/SlotPlayer.png")

onready var textures: Dictionary = {
	"Helmet": preload("res://Assets/UI/Inventory/Helmet.png"),
	"Weapon": preload("res://Assets/UI/Inventory/Weapon.png"),
	"Ring": preload("res://Assets/UI/Inventory/Ring.png"),
	"Boots": preload("res://Assets/UI/Inventory/Boots.png"),
	"Accessory": preload("res://Assets/UI/Inventory/Accessory.png"),
	"BodyArmor": preload("res://Assets/UI/Inventory/BodyArmor.png"),
}


