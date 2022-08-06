extends Entity

class_name EntityLife

var _enemys: PoolStringArray

var _attack_cooldown: float
var _last_attack: float

var _attackable_entities: PoolStringArray

onready var _health_bar: HealthBar = $HealthBar

func _start_cd(cooldown: float) -> void:
	_attack_cooldown = cooldown
	_last_attack = _attack_cooldown

func take_damage(damage: float) -> void:
	_life -= damage
	if _life < 0:
		_life = 0
	_health_bar._on_health_update(_life)

func update_health_bar(scale := Vector2(1,1)) -> void:
	_health_bar._on_max_health_updated(_life)
	_health_bar.set_scale(scale)
	_health_bar.set_offset(get_health_bar_off_set())
	
func get_health_bar_off_set() -> Vector2:
	return Vector2.ZERO
	
func isAttackOnCooldown() -> bool:
	if (_last_attack < 0):
		return true
	return false

func _check_collision(collision: KinematicCollision2D) -> void:
	if collision:
		if isAttackOnCooldown() and collision.collider.name in _attackable_entities:
			collision.collider.take_damage(5)
			_last_attack = 2.0
