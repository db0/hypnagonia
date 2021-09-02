class_name Player
extends Reference

signal artifact_added(artifact_name)

var health: int = 90 setget set_health
var damage: int setget set_damage
var deck: Deck
var pathos: Pathos
var artifacts := []

var deck_groups : Dictionary = {
	Terms.CARD_GROUP_TERMS.class: null,
	Terms.CARD_GROUP_TERMS.race: null,
	Terms.CARD_GROUP_TERMS.item: null,
	Terms.CARD_GROUP_TERMS.life_goal: null,
}


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
		health += CardGroupDefinitions[group.to_upper()][deck_groups[group]].get(Terms.PLAYER_TERMS.health,0)
	deck.assemble_starting_deck()


func get_currrent_archetypes() -> Array:
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


func set_health(value) -> void:
	health = int(round(value))
	if health < 0:
		health = 0
	if damage > health:
		damage = health


func compile_rarity_cards(rarity: String) -> Array:
	var rarity_cards := []
	for key in deck_groups:
		rarity_cards += CardGroupDefinitions[key.to_upper()][deck_groups[key]][rarity]
	return(rarity_cards)

func add_artifact(artifact_name: String) -> void:
	if not artifact_name in get_all_artifact_names():
		var new_artifact = ArtifactObject.new(artifact_name)
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

