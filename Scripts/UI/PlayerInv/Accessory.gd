extends EquiSlot


func _ready():
	base_size = 30
	slot_type = "Accessory"
	
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = textures[slot_type]
	refresh_style()

