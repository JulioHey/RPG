extends Inventory

onready var Equipements: Node2D = $Equipements

func _ready():
	for equi_slot in Equipements.get_children():
		equi_slot.connect("gui_input", self, "slot_gui_input", [equi_slot])

	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
