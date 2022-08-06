extends Node2D

class_name Ball

onready var Projectil = preload("res://Scenes/Misc/Projectil/Projectil.tscn")
onready var CdTimer: Timer = $CdTimer

var _texture: Texture
var base_cd: float = 2
var spell_in_cd: bool = true

func init(texture: Texture) -> void:
	_texture = texture		
	CdTimer.set_wait_time(base_cd)

func shot() -> void:
	if spell_in_cd:
		CdTimer.start()
		spell_in_cd = false
		var ball: Sprite  = Projectil.instance()
		ball.init(10, ["enemy"])
	#	ball.set_texture(_texture)
		Global.instance_node(ball, get_parent().global_position, get_parent())


func _on_CdTimer_timeout():
	spell_in_cd = true
