extends Modifier

class_name StatusModifer

enum INCREASE_TYPE {
	FLAT = 0,
	PERCENTAGE	
}

enum TIER {
	TIER_1 = 1,
	TIER_2,
	TIER_3,
	TIER_4,
	TIER_5,
	TIER_6,
}

var inscrease_type: int
var status: int
var tier: int
var value: float

func _init() -> void:
	type = 1
	inscrease_type = randi() % 2
	status = randi() % 3
	tier = randi() % 5
	value = randi() % 50

func _to_string() -> String:
	if inscrease_type:
		return "+ " + String(value) + " TO " + StatusUtils.STATUS_STR[status]
	else:
		return String(value) + " % INCREASED " + StatusUtils.STATUS_STR[status]
