extends KinematicBody2D

class_name Entity

var _speed: float
var _size: Vector2

var _life: float

onready var _collision_shape: CollisionShape2D = $Shape

func move(delta_position: Vector2) -> KinematicCollision2D:
	return move_and_collide(delta_position)

func getPosition() -> Vector2:
	return position

func setPosition(newPos: Vector2) -> void:
	position = newPos
