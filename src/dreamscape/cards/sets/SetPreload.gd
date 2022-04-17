class_name SetPreload
extends Node

# Counter intuitively, preloading is slower on game init!
# So disabling preloading these again

const CARD_SETS := [
#	preload("res://src/dreamscape/cards/sets/SetDefinition_Core.gd"),
#	preload("res://src/dreamscape/cards/sets/SetDefinition_LaserCannon.gd"),
#	preload("res://src/dreamscape/cards/sets/SetDefinition_Vindictive.gd"),
#	preload("res://src/dreamscape/cards/sets/SetDefinition_Enemies.gd"),
#	preload("res://src/dreamscape/cards/sets/SetDefinition_Perturbations.gd"),
]

const CARD_SCRIPTS := [
#	preload("res://src/dreamscape/cards/sets/SetScripts_Core.gd"),
#	preload("res://src/dreamscape/cards/sets/SetScripts_LaserCannon.gd"),
#	preload("res://src/dreamscape/cards/sets/SetScripts_Vindictive.gd"),
#	preload("res://src/dreamscape/cards/sets/SetScripts_Enemies.gd"),
#	preload("res://src/dreamscape/cards/sets/SetScripts_Perturbations.gd"),
]
