extends EquiSlot

export (Global.SIDE) var side

func _ready():
	base_size = 30
	
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = textures[slot]
	refresh_style()

func refresh(player_node: Node2D, item_node: Item, added: bool) -> void:
	refresh_style()
	if added:
		player_node.add_equip(item_node, _slot_to_str() + String(side))
	else:
		player_node.remove_equip(_slot_to_str() + String(side))
	
