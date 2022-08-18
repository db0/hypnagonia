extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "The Gatherer",
	"Rank": "Elite",
	"Health": 300,
	"Type": "Fear",
	"Damage": 0,
	"_texture_size_x": 180,
	"_texture_size_y": 180,
	"_character_art": 'Db0 via midjourney.com',
	"_is_ordered": true,
	"_health_variability": 20,
}


func _ready() -> void:
	cfc.NMAP.board.turn.connect("player_turn_started", self, "_check_dream_fragment")
#	cfc.NMAP.board.dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.disruption.name, 1, false, false, ["Init"])

func _check_dream_fragment(_turn: Turn) -> void:
	var found_dream_fragment := false
	for c in cfc.NMAP.hand.get_all_cards():
		if c.canonical_name == "Dream Fragment":
			found_dream_fragment = true
	if not found_dream_fragment:
		var spawn_fragment = [
			{
				"name": "spawn_card_to_container",
				"card_name": "Dream Fragment",
				"dest_container": "hand",
				"tags": [],
			}
		]
		intents.execute_special_script(spawn_fragment, self, self)
