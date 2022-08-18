extends Resource

class_name PlayerStatusController

var player_status: Array

var modifiers: Dictionary = {
	"Flat": [],
	"Percentage": []
}

func _init() -> void:
	for status in StatusUtils.STATUS_STR:
		player_status.append(0)

func output_player_status() -> void:
	for index in player_status.size():
		print(StatusUtils.STATUS_STR[index], ": ", String(player_status[index]))

func add_status_modifier(modifier: Modifier) -> void:
	status_mod(modifier)

func status_mod(modifier: StatusModifer) -> void:
	if modifier.inscrease_type:
		modifiers["Flat"].append([modifier.status, modifier.value])
	else:
		modifiers["Percentage"].append([modifier.status, modifier.value])

func update_status() -> void:
	for flat in modifiers["Flat"]:
		player_status[flat[0]] += flat[1]
	
	var percentage_array: Array = [0,0,0]
	
	for percentage in modifiers["Percentage"]:
		percentage_array[percentage[0]] += percentage[1]/100
	
	for index in player_status.size():
		player_status[index] += percentage_array[index] * player_status[index]
		
	output_player_status()

func clear_status() -> void:
	modifiers["Flat"].clear()
	modifiers["Percentage"].clear()
	player_status.clear()
	for status in StatusUtils.STATUS_STR:
		player_status.append(0)
	
