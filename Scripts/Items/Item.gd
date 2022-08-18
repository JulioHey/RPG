extends Node2D

class_name Item

		
var tooltip: ToolTip
onready var timer: Timer = $Timer
onready var texture: TextureRect = $TextureRect

var is_tooltiped: bool = false
var is_holding: bool = false

var modifiers: Array = [
	StatusModifer.new(),
	StatusModifer.new(),
	StatusModifer.new(),
	StatusModifer.new(),
]

var item_type: int

var item_title: String = "Item Pika"

func generate_new_item() -> void:
	item_type = randi() % 6

func _ready() -> void:
	generate_new_item()
	if randi() % 2 == 0:
		texture.texture = load("res://Assets/Items/Iron Sword.png")
	else:
		texture.texture = load("res://Assets/Items/Tree Branch.png")

func _physics_process(delta: float) -> void:
	if tooltip == null:
		tooltip = get_tree().get_root().get_node("MainScene/tooltip")

func set_size(new_size: Vector2) -> void:
	var scale: Vector2 = new_size / texture.get_rect().size
	set_scale(scale)
	texture.set_begin(Vector2.ZERO)
	texture.set_end(new_size)

func pick_from_slot() -> void:
	texture.set_position(texture.get_rect().size / -2)

func put_slot() -> void:
	texture.set_position(Vector2.ZERO)

func mouse_entered() -> void:
	timer.start()

func _check_mouse_position() -> bool:
	var size: Vector2 = texture.get_rect().size
	
	var rect: Rect2 = Rect2(global_position, size)
	
	return rect.has_point(get_global_mouse_position())
	
func _on_Timer_timeout():
	timer.set_wait_time(0.1)
	if !_check_mouse_position() || is_holding:
		timer.set_wait_time(0.5)
		tooltip.set_visible(false)
		timer.stop()
		is_tooltiped = false
	else:
		if !is_tooltiped:
			is_tooltiped = true
			tooltip.update_text(_construct_tooltip_dict())
		timer.start()

func _construct_tooltip_dict() -> Dictionary:
	var description: Array = []
	description.append(ItemUtils.ITEM_TYPES_STR[item_type])
	
	for modifier in modifiers:
		description.append(modifier._to_string())
		
	return {
		"Title": item_title,
		"Description": description
	}

