extends Control

class_name HealthBar

var _parent: Entity

onready var _health_bar: TextureProgress = $HealthBar

var _offset_from_parent: Vector2

	
func _ready() -> void:
	_parent = get_parent()

func _physics_process(_delta: float) -> void:
	set_position(_offset_from_parent)

func on_start_entity(life: float) -> void:
	_on_max_health_updated(life)

func _on_max_health_updated(maxHealth: float) -> void:
	_health_bar.set_max(maxHealth)
	_health_bar.set_value(maxHealth)

func _on_health_update(health: float) -> void:
	pass

func set_offset(offset: Vector2) -> void:
	_offset_from_parent = offset
