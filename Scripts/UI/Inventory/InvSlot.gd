extends Slot

var empty_tex: Texture = preload("res://Assets/UI/Inventory/Slot.png")
var default_tex: Texture = preload("res://Assets/UI/Inventory/Slot.png")

func _ready() -> void:
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	if randi() % 2 == 0:
		item = ItemClass.instance()
		add_child(item)
		
	refresh_style()



