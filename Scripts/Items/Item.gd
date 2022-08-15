extends Node2D

class_name Item

		
var tooltip: ToolTip
onready var timer: Timer = $Timer
onready var texture: TextureRect = $TextureRect

var is_tooltiped: bool = false
var is_holding: bool = false

var modifiers: Array = [
	"Strength +20",
	"Agi +20",
	"Mana +20",
	"Health +20",
]

var item_type: int

var item_title: String = "Meu Item Bala"

func generate_new_item(new_item_type: int) -> void:
	item_type = new_item_type

func _ready() -> void:
	generate_new_item(randi() % 6)
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
			tooltip.update_text(_construct_tooltip_bbcode(), modifiers.size() + 3)
		timer.start()

func _construct_tooltip_bbcode() -> String:
	var initial_string: String = "[b][center]"+item_title+"[/center][/b]"
	initial_string += "[center]"+ItemUtils.ITEM_TYPES_STR[item_type]+"[center]"
	for modifier in modifiers:
		initial_string += "[center]"+modifier+"[/center]"
	
	return initial_string

