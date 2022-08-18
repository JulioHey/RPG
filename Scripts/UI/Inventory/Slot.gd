extends Panel

class_name Slot

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Scenes/Items/Item.tscn")

var item: Item = null

var base_size: int = 20

export (ItemUtils.ITEM_TYPES) var slot


func refresh(player_node: Node2D, item_node: Item, added: bool) -> void:
	refresh_style()

func refresh_style() -> void:
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set("custom_styles/panel", default_style)
		
		
func pick_from_slot() -> void:
	pick_size(item)	
	remove_child(item)
	var player_node = find_parent("player")
	player_node.add_child(item)
	item = null
	refresh(player_node, item, false)

func put_into_slot(new_item: Node2D) -> void:
	item = new_item
	item.position = Vector2(0,0)
	var player_node = find_parent("player")
	player_node.remove_child(item)
	put_scale(item)
	add_child(item)
	
	refresh(player_node, item, true)

func put_scale(item: Item) -> void:
	item.set_size(get_rect().size)

func pick_size(item: Item) -> void:
	item.set_size(Vector2(20,20))

func accepts(item_type: int) -> bool:
	if slot == ItemUtils.ITEM_TYPES.ANY:
		return true
	return slot == item_type
