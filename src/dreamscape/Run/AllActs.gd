class_name AllActs
extends Act

const NCE := {
	"easy": [
		preload("res://src/dreamscape/Run/NCE/AllActs/TheCandyman.gd"),
	],
	"risky": [
		
	]
}

# These NCE need special triggers to be put into general rotation
# Each NCE is a dictionary with a key which points to the script to load from disk
# and a key which modifies how likely this event is to be encountered once it's unlocked
# A value of 1 means it's going to be encountered as much as any other NCE. 
# more than 1, and its increasing its chances to be encountered.
const LOCKED_NCE := {
	"DollPickup": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd"),
		"chance_multiplier": 2,
	},
	"PopPsychologist2": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"),
		"chance_multiplier": 2,
	},
	"PopPsychologist3": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"),
		"chance_multiplier": 3,
	},
}

static func get_act_name() -> String:
	return("AllActs")
