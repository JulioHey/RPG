extends EquiSlot


func _ready():
	base_size = 30
	
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = textures[slot]
	refresh_style()
