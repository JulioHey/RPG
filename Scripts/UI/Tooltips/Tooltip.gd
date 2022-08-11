extends Node2D

class_name ToolTip

onready var panel: Panel = $ToolTip
onready var label: RichTextLabel = $Label

const PADDING: int = 10
const WIDTH: int = 150

func _ready() -> void:
	set_name("tooltip")
	set_visible(false)

func _physics_process(delta: float) -> void:
	set_global_position(get_global_mouse_position())
		

func update_text(new_properties: String, number_lines: int) -> void:
	_set_text_from_item(new_properties, number_lines)
	set_visible(true)

func _set_text_from_item(properties: String, number_lines: int) -> void:
	var height: int = number_lines * 16

	panel.set_begin(Vector2.ZERO)
	label.set_begin(Vector2(PADDING, PADDING))
	panel.set_end(Vector2(WIDTH + 2 * PADDING, height + 2 * PADDING))
	label.set_end(Vector2(PADDING + WIDTH, height + PADDING))
	
	label.parse_bbcode(properties)
	
	
