extends Node


func instance_node(node: Node2D, location: Vector2, parent: Node2D) -> void:
	parent.add_child(node)
	node.global_position = location

enum SIDE {
	LEFT = 0,
	RIGHT
}
