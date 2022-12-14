extends Node2D

class_name Inventory

onready var inventory_slots: GridContainer = $Inv
var holding_item: Item = null
	
func slot_gui_input(event: InputEvent, slot: Slot) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed && slot:
			if holding_item != null:
				if !slot.item:
					if slot.accepts(holding_item.item_type):
						slot.put_into_slot(holding_item)
						holding_item.put_slot()
						holding_item = null
				else:
					var temp_item = slot.item
					slot.pick_from_slot()
					temp_item.global_position = event.global_position
					holding_item = temp_item	
			elif slot.item:
				holding_item = slot.item
				slot.pick_from_slot()
				holding_item.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()
	elif holding_item != null:
		holding_item.is_holding = true
	elif slot.item:
		slot.item.is_holding = false
		slot.item.mouse_entered()
									   

func _input(_event: InputEvent) -> void:
	if holding_item:		
		holding_item.global_position = get_global_mouse_position()
