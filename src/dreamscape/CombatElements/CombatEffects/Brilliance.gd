extends CombatEffect

func _ready() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_deck_shuffled")
	
func _on_deck_shuffled() -> void:
	var brilliance = [{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": 4,
			}]
	execute_script(brilliance)
