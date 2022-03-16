extends "res://tests/HUTCommon.gd"

# For easy access
var dreamer: PlayerEntity
var turn: Turn
var counters: Counters

var test_card_names := []
var test_artifact_names := []
var test_memories_names := []
var cards : Array
### used in spawn_test_torments()
var torments_amount := 1
# Holds the last torment spawned for easy access
var test_torment : EnemyEntity
# Holds all torments spawned
var test_torments := []
var starting_torment_dgm = 30
var test_torment_starting_effects := [
#	{
#		"name": ,
#		"amount": ,
#		"upgrade": ,
#	}
]
### Pathos
var set_repressed_pathos := {}
var set_released_pathos := {}
var card: DreamCard
var test_scripts := {}

func before_each():
	.before_each()
	var confirm_return = setup_board()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	yield(yield_for(0.1), YIELD)
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_repressed_pathos.has(pathos_name):
			globals.player.pathos.repressed[pathos_name] = set_repressed_pathos[pathos_name]
		else:
			globals.player.pathos.repressed[pathos_name] = 0
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_released_pathos.has(pathos_name):
			globals.player.pathos.released[pathos_name] = set_released_pathos[pathos_name]
		else:
			globals.player.pathos.released[pathos_name] = 0
	# We can override flags from test inner classer
	if not globals.test_flags.has("no_refill"):
		globals.test_flags["no_refill"] = true
	if globals.test_flags.get("start_ordeal_before_each", true):
		board.begin_encounter()
	dreamer = cfc.NMAP.board.dreamer
	turn = cfc.NMAP.board.turn
	counters = cfc.NMAP.board.counters
	cards = setup_test_cards(test_card_names)
	if cards.size() > 0:
		card = cards[0]
		if not test_scripts.empty():
			card.scripts = test_scripts
	artifacts = setup_test_artifacts(test_artifact_names)
	memories = setup_test_memories(test_memories_names)
	if globals.test_flags.get("start_ordeal_before_each", true):
		while board.counters.counters.immersion == 0:
			yield(yield_to(board.turn, "player_turn_started", 1), YIELD)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)

func after_each():
	.teardown_hypnagonia_testing()
	card = null
	test_scripts.clear()
	test_torments.clear()
	yield(yield_for(0.1), YIELD)


func spawn_test_torments() -> void:
	for _iter in range(torments_amount):
		test_torment = board.spawn_enemy(GUT_TORMENT)
		test_torment.add_to_group("BasicEnemyEntities")
		test_torment.damage = starting_torment_dgm
		test_torments.append(test_torment)
	for effect in test_torment_starting_effects:
		spawn_effect(test_torment, effect.name, effect.amount, effect.get("upgrade", ''))

	

func spawn_effect(target: CombatEntity, effect_name: String, amount: int, upgrade := '', tags := ['GUT']) -> void:
	target.active_effects.mod_effect(effect_name, amount, false, false, tags, upgrade)


func get_all_card_names() -> Array:
	var all_card_names := []
	for c in cfc.get_tree().get_nodes_in_group("cards"):
		all_card_names.append(c.canonical_name)
	return(all_card_names)

func count_card_names(card_name: String) -> int:
	var count := 0
	for cname in get_all_card_names():
		if cname == card_name:
			count += 1
	return(count)

func get_filtered_cards(property: String, value, comparison := 'eq') -> Array:
	var matching_cards := []
	var cfilter = CardFilter.new(property, value, comparison)
	for c in cfc.get_tree().get_nodes_in_group("cards"):
		if cfilter.check_card(c.properties):
			matching_cards.append(c)
	return(matching_cards)


func get_dreamer_effect_script(effect_name: String, amount: int) -> Dictionary:
	var apply_dreamer_effect_script := {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": effect_name,
					"subject": "dreamer",
					"modification": amount,
				}
			],
		},
	}
	return(apply_dreamer_effect_script)


# Returns the expected amount of damage, after including the torments starting dmgs
func tdamage(damage: int) -> int:
	return(starting_torment_dgm + damage)


func memexecute(memory: Memory, target: CombatEntity = null):
	var sceng = memory._use()
	if target:
		if not dreamer.targeting_arrow.is_targeting:
			yield(yield_to(dreamer.targeting_arrow, "initiated_targeting", 1), YIELD)
		dreamer.targeting_arrow.call_deferred("preselect_target", target)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	elif sceng and not sceng.all_tasks_completed:
		yield(yield_to(sceng, "tasks_completed", 0.2), YIELD)
	return(sceng)

func setup_deckpile_cards(_cards: Array) -> Array:
	var spawned_cards := []
	for c in _cards:
		var ce = CardEntry.new(c)
		var _card = ce.instance_self()
		cfc.NMAP.deck.add_child(_card)
		#card.set_is_faceup(false,true)
		_card._determine_idle_state()
		spawned_cards.append(_card)
	for c in spawned_cards:
		c.set_to_idle()
	return(spawned_cards)

func activate_quick_intent(intents_script: Array) -> void:
	var intents_to_test = [
		{
			"intent_scripts": intents_script,
			"reshuffle": true,
		}]
	test_torment.intents.replace_intents(intents_to_test)
	test_torment.intents.refresh_intents()
	yield(yield_for(0.1), YIELD)
	turn.end_player_turn()
	yield(yield_to(turn, "player_turn_started", 3), YIELD)
