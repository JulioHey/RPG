extends Panel

class_name Slot

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Scenes/Items/Item.tscn")

var item: Node2D = null

var base_size: int = 20

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
	refresh_style()

func put_into_slot(new_item: Item) -> void:
	item = new_item
	item.position = Vector2(0,0)
	var player_node = find_parent("player")
	player_node.remove_child(item)
	put_scale(item)
	add_child(item)
	
	refresh_style()
	
func put_scale(item: Item) -> void:
	item.set_size(get_rect().size)

func pick_size(item: Item) -> void:
	item.set_size(Vector2(20,20))
