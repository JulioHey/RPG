extends EquiSlot


func _ready():
	base_size = 30
	slot_name = "Ring"
	
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = textures[slot_name]
	refresh_style()
