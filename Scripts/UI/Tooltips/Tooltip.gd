extends Node2D

class_name ToolTip

onready var title_panel: Panel = $TitlePanel
onready var title_label: RichTextLabel = title_panel.get_child(0)
onready var description_panel: Panel = $DescriptionPanel
onready var description_label: RichTextLabel = description_panel.get_child(0)

const PADDING: int = 10
const WIDTH: int = 150

const MAX_CHAR_TITLE_LINE: int = 13

func _ready() -> void:
	description_label.set_fit_content_height(true) 
	title_label.set_fit_content_height(true) 
	set_name("tooltip")
	set_visible(false)

func _physics_process(delta: float) -> void:
	set_global_position(get_global_mouse_position())
		

func update_text(new_properties: Dictionary) -> void:
	_set_text_from_item(new_properties)
	set_visible(true)
	
func _set_text_from_item(properties: Dictionary) -> void:
	var end_title: int = _set_title(properties["Title"])
	_set_description(properties["Description"], end_title)

	
func _set_title(title: String) -> int:
	title_label.parse_bbcode(_construct_title_bbcode(title))
	title_panel.set_begin(Vector2.ZERO)
	var end: int = 16 *_get_number_of_lines(title, MAX_CHAR_TITLE_LINE) + PADDING
	title_panel.set_end(Vector2(WIDTH + 2* PADDING, 16 *_get_number_of_lines(title, MAX_CHAR_TITLE_LINE) + PADDING))
	return end

func _get_number_of_lines(target_string: String, max_char_line: int) -> int:
	var words: Array = target_string.split(" ")
	var n_lines: int = 1
	
	var current_line_chars: int = 0
	for word in words:
		current_line_chars += word.length() + 1
		if current_line_chars > max_char_line:
			current_line_chars -= max_char_line
			n_lines += 1
	
	return n_lines
	
func _construct_title_bbcode(title: String) -> String:
	var initial_string: String = "[b][center]"+title+"[/center][/b]"
	
	return initial_string

func _construct_modifier_bbcode(modifier: String) -> Array:
	var initial_string: String = ""
	initial_string += "[center]"+modifier+"[/center]"
	var n_lines: int = _get_number_of_lines(modifier, MAX_CHAR_TITLE_LINE + 2)
	return [initial_string, n_lines]

func _set_description(descriptions: Array, end: int) -> void:
	var bb_code: String = ""
	var n_lines: int = 0
	for modifier in descriptions:
		var value = _construct_modifier_bbcode(modifier)
		bb_code += value[0]
		n_lines += value[1]
	
	print(n_lines)
		
	description_label.parse_bbcode(bb_code)
	description_panel.set_begin(Vector2(0, end))
	description_panel.set_end(Vector2(WIDTH + 2 * PADDING, end + n_lines * 14 + PADDING))
#
