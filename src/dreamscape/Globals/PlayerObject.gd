class_name Player
extends Reference

signal artifact_added(artifact_name)
signal memory_added(memory_name)
signal health_changed(damage, health)

var health: int = 90 setget set_health
var damage: int = 0 setget set_damage
var deck: Deck
var pathos: Pathos
var artifacts := []
var memories := []

var deck_groups : Dictionary = {
	Terms.CARD_GROUP_TERMS.class: null,
	Terms.CARD_GROUP_TERMS.race: null,
	Terms.CARD_GROUP_TERMS.item: null,
	Terms.CARD_GROUP_TERMS.life_goal: null,
}


# Returns false if not all deck archetypes have been selected for the deck
func is_deck_completed() -> bool:
	for archetype in deck_groups:
		if not deck_groups[archetype]:
			return(false)
	return(true)


func setup() -> void:
	pathos = Pathos.new()
	deck = Deck.new(deck_groups)
	for group in deck_groups:
		# Each deck group can modify the player's max health
		health += Aspects[group.to_upper()][deck_groups[group]].get(Terms.PLAYER_TERMS.health,0)
		# Each deck group might provide one or more starting artifacts
		for artifact_name in Aspects[group.to_upper()][deck_groups[group]].get("Starting Artifacts", []):
			add_artifact(artifact_name.canonical_name)
	deck.assemble_starting_deck()
	# Debug #
#	add_artifact("StartingImmersion")
#	add_artifact("PerturbationHeal")
#	deck.add_new_card("@ Inner Justice @")
#	deck.add_new_card("Dread")

func get_current_archetypes() -> Array:
	var all_archetypes := []
	for aspect in deck_groups:
		if deck_groups[aspect]:
			all_archetypes.append(deck_groups[aspect])
	return(all_archetypes)


func set_damage(value) -> void:
	damage = int(round(value))
	if damage > health:
		damage = health
	elif damage < 0:
		damage = 0
	emit_signal("health_changed", damage, health)


func set_health(value) -> void:
	health = int(round(value))
	if health < 0:
		health = 0
	if damage > health:
		damage = health
	emit_signal("health_changed", damage, health)


# Returns all card names of the chosen rarity among all the archetypes
# assigned to the player
func compile_rarity_cards(rarity: String, aspect_limit = null) -> Array:
	var rarity_cards := []
	for key in deck_groups:
		if aspect_limit and key != aspect_limit:
			continue
		rarity_cards += Aspects[key.to_upper()][deck_groups[key]][rarity]
	return(rarity_cards)


# Returns all cards from the player's archetypes which match a specific card type 
# and are of any of the given rarities
func compile_card_type(
		type: String, 
		rarities := ["Common","Uncommon", "Rare"],
		upgraded := false) -> Array:
	if type == "Perturbation":
		return(Perturbations.gather_perturbations(get_archetype_perturbations()))
	if type == "Understanding":
		# gather_understanding() uses a trinary choice for knowing whether to
		# return upgraded cards. So we need to convert our bool into yes/no string
		var upgraded_choice := {true:"yes", false:"no"}
		return(Understanding.gather_understanding(upgraded_choice[upgraded]))
	var all_cards :=  []
	for rarity in rarities:
		all_cards += compile_rarity_cards(rarity)
	var typecards := []
	for card_name in all_cards:
		if cfc.card_definitions[card_name].get(CardConfig.SCENE_PROPERTY) == type:
			if (upgraded and not cfc.card_definitions[card_name].get("_is_upgrade"))\
					or (not upgraded and cfc.card_definitions[card_name].get("_is_upgrade")):
				continue
			typecards.append(card_name)
	return(typecards)


func add_artifact(artifact_name: String, modifiers := {}) -> void:
	if not artifact_name in get_all_artifact_names():
		var new_artifact = ArtifactObject.new(artifact_name, modifiers)
		artifacts.append(new_artifact)
		emit_signal("artifact_added", new_artifact)


func remove_artifact(artifact_name: String) -> void:
	for artifact in artifacts:
		if artifact_name == artifact.canonical_name:
			artifact.remove_self()
			artifacts.erase(artifact)


func get_all_artifact_names() -> Array:
	var anames_list = []
	for artifact in artifacts:
		anames_list.append(artifact.canonical_name)
	return(anames_list)


func add_memory(memory_name: String, modifiers := {}) -> void:
	# The dreamer can only hold 1 memory for each type of pathos.
	# If they already have a memory for that pathos, nothing happens.
	if does_memory_type_exist(memory_name):
		return
	var new_memory = MemoryObject.new(memory_name, modifiers)
	memories.append(new_memory)
	emit_signal("memory_added", new_memory)


func find_memory(memory_name: String):
	for memory in memories:
		if memory.canonical_name == memory_name:
			return(memory)

# If the player already has another memory using the same pathos, returns true
# else, returns false
func does_memory_type_exist(memory_name) -> bool:
	var definition = MemoryDefinitions.find_memory_from_canonical_name(memory_name)
	for memory in memories:
		if definition.pathos == memory.pathos_used:
			return(true)
	return(false)


func remove_memory(memory_name: String) -> void:
	for memory in memories:
		if memory_name == memory.canonical_name:
			memory.remove_self()
			memories.erase(memory)


func get_all_memory_names() -> Array:
	var mnames_list = []
	for memory in memories:
		mnames_list.append(memory.canonical_name)
	return(mnames_list)


# Goes through all archetypes and gathers all artifacts specified
# Returns a list with all artifacts tied to all archetypes of the player.
func get_archetype_artifacts() -> Array:
	var artifact_list := []
	for arch in get_current_archetypes():
		artifact_list += Aspects.get_archetype_value(arch, "Artifacts")
	return(artifact_list)

# Goes through all archetypes and gathers all artifacts specified
# Returns a list with all artifacts tied to all archetypes of the player.
func get_archetype_memories() -> Array:
	var memories_list := []
	for arch in get_current_archetypes():
		memories_list += Aspects.get_archetype_value(arch, "Memories")
	return(memories_list)


# Goes through all archetypes and gathers all parturbations specified
# Returns a list with all perturbations tied to all archetypes of the player.
# Typically all perturbations have a chance to appear in all archetypes
# But the extra perturbations specified in each archetype, increase the chance
# for the specified perturbations to appear when that archetype is being used.
func get_archetype_perturbations() -> Array:
	var perturbations := []
	for arch in get_current_archetypes():
		perturbations += Aspects.get_archetype_value(arch, "Perturbations")
	return(perturbations)
