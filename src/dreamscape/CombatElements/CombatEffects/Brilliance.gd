extends CombatEffect

func _ready() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_deck_shuffled")
	
func _on_deck_shuffled(_deck) -> void:
	var core_amount = 4
	if upgrade == "blinding":
		core_amount = 6
	var brilliance = [{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": core_amount * stacks,
			}]
	execute_script(brilliance)
