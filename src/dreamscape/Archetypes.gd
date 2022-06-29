# The definitions of the various archetypes.
# Each archetype has the fields that define which cards are available
# in the starting deck, as well as in the draft card pool presented
# to the player
# It also list all other definitions needed, such as restricted artifacts
# tags, icons etc.
class_name Archetypes
extends Reference

const FLYER:= {
	"Anxiety": +5,
	"Icon": preload("res://assets/archetypes/flyer.jpg"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.impervious.name,
		Terms.GENERIC_TAGS.relax.name,
	],
	"Artifacts": [
		ArtifactDefinitions.ImproveImpervious,
		ArtifactDefinitions.ConstantImpervious
	],
	"Memories": [
		MemoryDefinitions.ImperviousSelf,
		MemoryDefinitions.RegenerateSelf,
	],
	"Perturbations": [

	],
	"Basic": [
		"Out of Reach",
		"Interpretation",
		"Confidence",
	],
	"Common": [
		"Dive-in",
		"Overview",
		"Drag and Drop",
		"Loop de loop",
		"Rapid Encirclement",
		"Dodge",
		"Running Start",
	],
	"Uncommon": [
		"Safety of Air",
		"Whirlwind",
		"Swoop",
		"Barrel Through",
		"Launch",
		"Careful Observation",
		"Introspection",
		"Find Weakness",
		"Near-ground Flight"
	],
	"Rare": [
		"Master of Skies",
		"Zen of Flight",
		"Panicked Takeoff",
	]
}

const MAD_SCIENTIST := {
	"Icon": preload("res://assets/archetypes/Mad Scientist.jpg"),
	"Tags": [
		Terms.GENERIC_TAGS.spark.name,
		Terms.ACTIVE_EFFECTS.buffer.name,
	],
	"Artifacts": [
		ArtifactDefinitions.IncreaseBufferStacks
	],
	"Memories": [
		MemoryDefinitions.ReshuffleHand,
		MemoryDefinitions.BufferSelf,
	],
	"Perturbations": [
		"Apathy",
	],
	"Basic": [
		"Confidence",
		"Change of Mind",
		"Change of Mind",
	],
	"Common": [
		"Recall",
		"Vexing Concept",
		"Blind Trial",
		"Hyperfocus",
		"Misunderstood",
		"Misplaced Research",
	],
	"Uncommon": [
		"Brilliance",
		"Rapid Theorizing",
		"Wild Inspiration",
		"Detect Weaknesses",
		"Death Ray",
		"Unconventional",
		"Endless Posibilities",
		"A Fine Specimen",
		"Mania",
	],
	"Rare": [
		"It's alive!",
		"Eureka!",
		"I'll Show Them All",
		"Excogitate",
	],
}

const WARRIOR:= {
	"Anxiety": 5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [

	],
	"Memories": [

	],
	"Perturbations": [

	],
	"Basic": [
		"War Paint",
	],
	"Common": [
		"War Paint",
	],
	"Uncommon": [
	],
	"Rare": [],
	"_is_inactive": true
}

const RUNNER := {
	"Anxiety": 5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [

	],
	"Memories": [

	],
	"Perturbations": [

	],
	"Basic": [
	],
	"Common": [
		"Rapid Encirclement",
	],
	"Uncommon": [
		"Barrel Through",
	],
	"Rare": [],
	"_is_inactive": true
}


const FEARLESS:= {
	"Anxiety": +5,
	"Icon": preload("res://assets/archetypes/fearless.jpg"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.poison.name,
		Terms.ACTIVE_EFFECTS.fortify.name,
	],
	"Artifacts": [
		ArtifactDefinitions.ImprovePoison,
		ArtifactDefinitions.ImproveFortify,
		ArtifactDefinitions.IncreasePoisonStacks,
		ArtifactDefinitions.StartingFortify,
	],
	"Memories": [
		MemoryDefinitions.PoisonEnemy,
		MemoryDefinitions.FortifySelf,
	],
	"Perturbations": [
		"Self-Centered",
	],
	"Basic": [
		"Confidence",
		"Confidence",
		"Nothing to Fear",
	],
	"Common": [
		"Intimidate",
		"Towering Presence",
		"Audacity",
		"Solid Understanding",
		"Confident Slap",
		"Cocky Retort",
		"The Finger",
	],
	"Uncommon": [
		"Barrel Through",
		"Cheeky Approach",
		"No Second Thoughts",
		"High Morale",
		"Impugn",
		"Tenacity",
		"Bring It!",
		"Sanguine",
	],
	"Rare": [
		"Laugh at Danger",
		"Unassailable",
		"Boast",
		"Unshakeable"
	]
}
const VINDICTIVE:= {
	"Anxiety": +2,
#	"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.frozen.name,
		Terms.ACTIVE_EFFECTS.thorns.name,
	],
	"Artifacts": [
		ArtifactDefinitions.ImproveThorns,
		ArtifactDefinitions.StartingThorns,
	],
	"Memories": [
		MemoryDefinitions.ThornsSelf,
		MemoryDefinitions.FreezeCard,
	],
	"Perturbations": [
		"Self-Centered",
	],
	"Basic": [
		"Confidence",
		"Confidence",
		"Keep in Mind",
	],
	"Common": [
		"Moving On",
		"Fist of Candies",
		"Hand of Grudge",
		"Reactionary",
		"That's Going in the Book",
	],
	"Uncommon": [
		"Memento of Anger",
		"Memento of Safety",
		"Vestige of Warmth",
		"Stewing",
		"Note-Taking",
		"Vengeance",
		"Planning",
		"Saved for Later",
		"Reckoning Time",
		"Prepared",
	],
	"Rare": [
		"The Cold Dish",
		"Nothing Forgotten",
		"Schadenfreude",
		"The Last Straw",
	]
}
	# Archetypes: Self-harm
const COWARD := {
	"Anxiety": -5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [

	],
	"Memories": [

	],
	"Perturbations": [

	],
	"_is_inactive": true
}


const RUBBER_CHICKEN := {
	"Icon": preload("res://assets/archetypes/Rubber Chicken.jpg"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.disempower.name,
		Terms.ACTIVE_EFFECTS.buffer.name,
	],
	"Artifacts": [
		ArtifactDefinitions.IncreaseConfusionStacks
	],
	"Memories": [
		MemoryDefinitions.DisempowerEnemy,
	],
	"Perturbations": [

	],
	"Basic": [
		"Interpretation",
		"Noisy Whip",
		"Noisy Whip",
	],
	"Common": [
		"Confounding Movements",
		"Ventriloquism",
		"Cockfighting",
		"A Thousand Squeaks",
		"A Strange Gaida",
		"Massive Eggression",
	],
	"Uncommon": [
		"Mania",
		"Rubber Eggs",
		"The Joke",
		"Fowl Language",
		"Absurdity Unleashed",
		"A Chick of the Light",
		"One With The Poultry",
		"Sensuous",
		"The Plot Chickens...",
	],
	"Rare": [
		"Nunclucks",
		"Utterly Ridiculous",
		"The Whippy-Flippy",
		"Sneaky-Beaky",
	]
}
const LASER_CANNON := {
#	"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.fusion.name,
		Terms.GENERIC_TAGS.startup.name,
	],
	"Artifacts": [
		ArtifactDefinitions.DoubleFirstStartup,
		ArtifactDefinitions.DoubleFusion,
	],
	"Memories": [
		MemoryDefinitions.ActivateStartups,
	],
	"Perturbations": [

	],
	"Basic": [
		"Interpretation",
		"Interpretation",
		"Light Jump",
	],
	"Common": [
		"Cannon",
		"Vulcan",
		"Photon Shield",
		"Photon Blade",
		"Blinding Flash",
		"Quick Dash",
	],
	"Uncommon": [
		"Charged Shot",
		"Dark Recovery",
		"Dark Approach",
		"Widebeam",
		"Heat Venting",
		"Streamlining",
		"Brooding",
		"Recycling",
		"Focus Calibration",
	],
	"Rare": [
		"Precision",
		"Nano-Machines",
		"Spare Lens",
		"Universal Component",
	],
	"Special": [
		"HiCannon",
		"MegaCannon",
		"Vulcan2",
		"Vulcan3",
		"Lumen Shield",
		"Plasma Shield",
		"Fusion Grenade",
	]
}


const ABUSIVE_RELATIONSHIP := {
	"Anxiety": +5,
	"Icon": preload("res://assets/archetypes/Abusive Relationship.jpg"),
	"Tags": [
		Terms.GENERIC_TAGS.purpose.name,
		Terms.GENERIC_TAGS.exert.name,
	],
	"Artifacts": [
		ArtifactDefinitions.IncreaseImmersionGain,
		ArtifactDefinitions.DecreaseExertStacks,
		ArtifactDefinitions.LimitMaxExert,
	],
	"Memories": [
		MemoryDefinitions.ExertRecovery,
		MemoryDefinitions.ExertSelf,
	],
	"Starting Artifacts": [
		ArtifactDefinitions.EndingHeal
	],
	"Perturbations": [

	],
	"Basic": [
		"Inner Justice",
		"Interpretation",
		"Confidence",
	],
	"Common": [
		"Confrontation",
		"Could Be Worse",
		"Dismissal",
		"It's not about me",
		"Perseverance",
	],
	"Uncommon": [
		"Is it my fault?",
		"It's The Small Things",
		"That too, shall pass",
		"Flashbacks",
		"Enough is enough!",
		"Grit",
		"Self-Deception",
		"Rancor",
		"Lash-out",
		"Survival Mode",
		"Excuses",
	],
	"Rare": [
		"The Happy Place",
		"Tolerance",
		"Catatonia",
		"Disengage"
	]
}
const EXPLOITED := {
	"Anxiety": -5,
#		"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.slumber.name,
	],
	"Artifacts": [
	],
	"Memories": [
	],
	"Starting Artifacts": [
		ArtifactDefinitions.SavedReleases
	],
	"Perturbations": [

	],
	"Basic": [
		"Interpretation",
		"Confidence",
		"Exhaustion",
	],
	"Common": [
	],
	"Uncommon": [
		"Prepared",
		"Keep 'em Coming",
		"Know Your Limits",
	],
	"Rare": [
	]
}
