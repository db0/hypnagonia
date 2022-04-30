class_name AllActs
extends Act

const NCE := {
	"easy": {
		"TheCandyman": "res://src/dreamscape/Run/NCE/AllActs/TheCandyman.gd",
		"PottedPlant": "res://src/dreamscape/Run/NCE/AllActs/PottedPlant.gd",
	},
	"risky": {
		"EpicUpgrade": "res://src/dreamscape/Run/NCE/AllActs/EpicUpgrade.gd",
		"OstrichEggs": "res://src/dreamscape/Run/NCE/AllActs/OstrichEggs.gd",
	}
}

# These NCE need special triggers to be put into general rotation
# Each NCE is a dictionary with a key which points to the script to load from disk
# and a key which modifies how likely this event is to be encountered once it's unlocked
# A value of 1 means it's going to be encountered as much as any other NCE. 
# more than 1, and its increasing its chances to be encountered.
const LOCKED_NCE := {
	"DollPickup": {
		"nce": "res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd",
		"chance_multiplier": 2,
	},
	"PopPsychologist2": {
		"nce": "res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd",
		"chance_multiplier": 2,
	},
	"PopPsychologist3": {
		"nce": "res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd",
		"chance_multiplier": 3,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.All)

# These NCEs never go to the Used NCEs
# As such, they can reapper once per act
const REPEATING_NCE := [
	"res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd",
]
