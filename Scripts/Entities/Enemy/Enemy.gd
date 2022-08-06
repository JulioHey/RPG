extends EntityLife

var _player: Entity

var _time_of_death_animation: float = 1
var _time_since_death: float = 0
var _dead: bool = false

onready var _animation: AnimationPlayer = $AnimationPlayer

func _ready():
	_start_variables()
	_update_super_classes()
	
func _update_super_classes() -> void:
	_start_cd(2.0)
	set_name("enemy")
	update_health_bar(Vector2(0.25, 0.25))
	set_position(Vector2(200.0, 200.0))
	
func _start_variables() -> void:
	_player = get_parent().get_node("player")
	_size = Vector2(10.0, 10.0)
	_speed = 50.0
	_life = 20.0
	_attackable_entities = PoolStringArray(["player"])

func _physics_process(delta: float) -> void:
	if !_dead:
		_update_enemy(delta)
	_on_death(delta)

func _get_player_distance() -> float:
	var direction: float = global_position.distance_to(_player.global_position)
	return direction

func _get_player_direction() -> Vector2:
	var direction: Vector2 = global_position.direction_to(_player.global_position)
	return direction

func _follow_player(delta: float) -> void:
	var direction = _get_player_direction()
	var deltaPosition = direction * _speed * delta
	_check_collision(move(deltaPosition))


func _update_enemy(delta: float) -> void:
	_last_attack -= delta
	_follow_player(delta)
	update()
	

func get_health_bar_off_set() -> Vector2:
	var offset: Vector2 = Vector2.ZERO
	offset.x = - _health_bar.get_size().x / 2
	offset.y = - 3 *_size.y
	return offset

func _on_death(delta: float):
	if _life == 0:
		_dead = true
		_animation.play("Death")
	if _dead:
		_time_since_death += delta
	if _time_since_death > _time_of_death_animation:
		queue_free()
