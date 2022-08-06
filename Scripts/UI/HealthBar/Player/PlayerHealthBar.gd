extends HealthBar

onready var _health_bar_under: TextureProgress = $HealthBarUnder
onready var _update_tween: Tween = $UpdateTween

export (Color) var health_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red

export (float, 0, 1, 0.5) var caution_zone = 0.5
export (float, 0, 1, 0.5) var danger_zone = 0.25


func _on_health_update(health: float) -> void:
	_health_bar.value = health
	_update_tween.interpolate_property(_health_bar_under, "value", _health_bar_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.2)
	_update_tween.start()
	
	_assign_color(health)

func _assign_color(health: float) -> void:
	if (health <= _health_bar.max_value * danger_zone):
		_health_bar.tint_progress = danger_color
	elif (health <= _health_bar.max_value * caution_zone):
		_health_bar.tint_progress = caution_color
	else:
		_health_bar.tint_progress = health_color

func _on_max_health_updated(max_health: float) -> void:
	_health_bar.set_max(max_health)
	_health_bar.set_value(max_health)
	_health_bar_under.set_max(max_health)
	_health_bar_under.set_value(max_health)

