extends Sprite

var movement: Vector2 = Vector2(1,0)
var velocidade: float = 200
var dir_unica: bool = true

var _damage: float
var _list_of_targets: Array

func init(damage: float, list_of_targets: Array) -> void:
	_damage = damage
	_list_of_targets = list_of_targets
	
func _physics_process(delta: float) -> void:
	if dir_unica:
		look_at(get_global_mouse_position())
		dir_unica = false
	
	global_position += movement.rotated(rotation) * velocidade * delta
	
func _on_Notifier_screen_exited():
	queue_free()


func _on_projetil_area_body_entered(body):
	if body.name in _list_of_targets:
		body.take_damage(_damage)
