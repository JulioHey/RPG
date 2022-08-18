extends EntityLife


onready var Ball = preload("res://Scenes/Spells/Ball.tscn")

onready var _animation = $AnimationPlayer
onready var _inventory = $Inventory
var _equipements: Dictionary = {}

onready var holding_item: Item = null

var _inventory_visibility: bool = false

var ball: Node2D

var player_status_controller: PlayerStatusController

func _ready() -> void:
	ball = Ball.instance()
	add_child(ball)
	_start_variables()
	_update_super_classes()
	_start_player_variables()

func _start_player_variables() -> void:
	player_status_controller = PlayerStatusController.new()

func _update_super_classes() -> void:
	set_name("player")
	update_health_bar()
	global_position = Vector2(100.0, 100.0)
	_start_cd(2.0)
	
func _start_variables() -> void:
	_inventory.set_scale(Vector2.ZERO)
	_size = Vector2(10.0, 10.0)
	_speed = 100.0
	_life = 20.0
	_attackable_entities = PoolStringArray(["enemy"])
	
func _physics_process(delta: float) -> void:
	_update_player(delta)
	update()

func _update_player(delta) -> void:
	checkMovement(delta)
	checkActions()
	_last_attack -= delta

func checkMovement(delta: float) -> void:
	var direction: Vector2 = Vector2(0.0, 0.0)
	if (Input.is_key_pressed(KEY_W)):
		direction.y -= 1.0
	if (Input.is_key_pressed(KEY_S)):
		direction.y += 1.0
	if (Input.is_key_pressed(KEY_D)):
		direction.x += 1.0
	if (Input.is_key_pressed(KEY_A)):
		direction.x -= 1.0
	
	update_texture(direction)
	
	if (direction.x != 0.0 or direction.y != 0.0):
		var delta_position = delta * direction * _speed
		var collision = move(delta_position)
		_check_collision(collision)

func update_texture(direction: Vector2) -> void:
	var anim = "Idle"
	if direction.x != 0:
		$PlayerSprite.scale.x = direction.x
		anim = "Run"
	if direction.y != 0:
		anim = "Run"
	
	if _animation.current_animation != anim:
		_animation.stop(true)
		_animation.play(anim)
		_animation.set_current_animation(anim)

func get_health_bar_off_set() -> Vector2:
	var center_of_screen = get_tree().root.get_visible_rect().size
	return (center_of_screen / 2) * -1

func checkActions() -> void:
	if Input.is_action_just_pressed("shot"):
		ball.shot()
	if Input.is_action_just_released("open_inventory"):
		if _inventory_visibility:
			_inventory.set_scale(Vector2.ZERO)
		else:
			_inventory.set_scale(Vector2(1,1))
		_inventory_visibility = !_inventory_visibility

func add_equip(item: Item, slot: String):
	_equipements[slot] = item
	update_player_modifiers()

func remove_equip(slot: String):
	_equipements[slot] = null
	update_player_modifiers()

func update_player_modifiers() -> void:
	player_status_controller.clear_status()
	for equipement in _equipements.values():
		if equipement:
			for modifier in equipement.modifiers:
				player_status_controller.add_status_modifier(modifier)		
	
	player_status_controller.update_status()

