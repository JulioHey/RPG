extends Resource

class_name PlayerStatusController

var player_status: Array

const FLAT = 0
const PERCENTAGE = 1

var modifiers: Dictionary = {
	FLAT: [],
	PERCENTAGE: []
}

var resume_modifier: Dictionary = {
	FLAT: [],
	PERCENTAGE: [],
}

func _init() -> void:
	for status in StatusUtils.STATUS_STR:
		player_status.append(0)
		resume_modifier[FLAT].append(0)
		resume_modifier[PERCENTAGE].append(0)
	for type in ModifierUtils.CHANGES_TO_PLAYER_ARRAY.size():
		modifiers[FLAT].append({})
		modifiers[PERCENTAGE].append({})
		construct_dict_for_type(type)

func output_player_status() -> void:
	for index in player_status.size():
		print(StatusUtils.STATUS_STR[index], ": ", String(player_status[index]))

func add_status_modifier(modifier: Modifier, type: int, key: String) -> void:
	status_mod(modifier, type, key)

func status_mod(modifier: StatusModifer, type: int, key: String) -> void:
	if modifier.inscrease_type:
		modifiers[FLAT][type][key].append([modifier.status, modifier.value])
	else:
		modifiers[PERCENTAGE][type][key].append([modifier.status, modifier.value])

func update_status(type: int, key: String) -> void:
	for tuple in modifiers[FLAT][type][key]:
		resume_modifier[FLAT][tuple[0]] += tuple[1]
	for tuple in modifiers[PERCENTAGE][type][key]:
		resume_modifier[PERCENTAGE][tuple[0]] += tuple[1]
	
	recalculate_final_status()
	output_player_status()


func add_item_to_calc(item: Item, type: int, key: String) -> void:
	if item != null:
		for modifier in item.modifiers:
			add_status_modifier(modifier, type, key)
		update_status(type, key)
	else:
		remove_status_from_old_item(type, key)
		update_status(type, key)
	
func remove_status_from_old_item(type: int, key: String) -> void:
	for tuple in modifiers[FLAT][type][key]:
		resume_modifier[FLAT][tuple[0]] -= tuple[1]
	for tuple in modifiers[PERCENTAGE][type][key]:
		resume_modifier[PERCENTAGE][tuple[0]] -= tuple[1]
	
	modifiers[FLAT][type][key].clear()
	modifiers[PERCENTAGE][type][key].clear()
	
func construct_dict_for_type(type: int) -> void:
	for key in ModifierUtils.KEYS_ARRAY[type]:
		modifiers[FLAT][type][key] = []
		modifiers[PERCENTAGE][type][key] = []

func recalculate_final_status() -> void:
	
	for status in StatusUtils.STATUS_STR.size():
		player_status[status] = resume_modifier[FLAT][status]
		player_status[status] *= 1 + (resume_modifier[PERCENTAGE][status]/100)
		
		
