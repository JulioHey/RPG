extends HealthBar

onready var health_bar: TextureProgress = $HealthBar

func _on_health_update(health: float) -> void:
	health_bar.value = health
