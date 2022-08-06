extends Node2D

class_name Item

var tooltip: ToolTip
onready var timer: Timer = $Timer


var dale: int = 0

var is_holding: bool = false

var properties: Dictionary = {
	"Strength": "+20",
	"Agi": "+20",
	"Mana": "+20",
	"Health": "+20",
}

func _ready() -> void:
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://Assets/Items/Iron Sword.png")
	else:
		$TextureRect.texture = load("res://Assets/Items/Tree Branch.png")

func _physics_process(delta: float) -> void:
	if tooltip == null:
		tooltip = get_tree().get_root().get_node("MainScene/tooltip")

func set_size(new_size: Vector2) -> void:
	var scale: Vector2 = new_size / $TextureRect.get_rect().size
	set_scale(scale)
	$TextureRect.set_begin(Vector2.ZERO)
	$TextureRect.set_end(new_size)


func mouse_entered() -> void:
	timer.start()

func set_properties(new_properties: Dictionary) -> void:
	properties = new_properties


func _check_mouse_position() -> bool:
	var size: Vector2 = $TextureRect.get_rect().size
	
	var rect: Rect2 = Rect2(global_position, size)
	
	return rect.has_point(get_global_mouse_position())
	
func _on_Timer_timeout():
	timer.set_wait_time(0.1)
	tooltip.update_text(properties)
	if !_check_mouse_position() || is_holding:
		timer.set_wait_time(0.5)
		tooltip.set_visible(false)
		timer.stop()
	else:
		timer.start()
