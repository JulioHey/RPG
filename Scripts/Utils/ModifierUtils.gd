extends Node

enum MODIFIER_TYPES {
	ATTR,
}

enum CHANGES_TO_PLAYER {
	EQUIPS = 0,
	AURAS,
	POTIONS,
	BUFFS,
	SKILL_TREE
}

const CHANGES_TO_PLAYER_ARRAY = [
	"EQUIPS",
	"AURAS",
	"POTIONS",
	"BUFFS",
	"SKILL_TREE"
]

const EQUIP_ARRAY = [
	"Helmet",
	"BodyArmor",
	"Weapon0",
	"Weapon1",
	"Ring0",
	"Ring1",
	"Accessory1",
	"Accessory0",
	"Boots",
]

const KEYS_ARRAY: Array = [
	EQUIP_ARRAY,
	[],
	[],
	[],
	[],
]
