class_name IntentScripts
extends Reference

const INTENTS := {
	"Attack": [
		{
			"name": "modify_damage",
			"tags": ["Damage", "Intent"],
			"subject": "dreamer",
			"amount": null,
			"icon": null,
			"description": "A basic attack. Will cause the dreamer to take the specified amount of anxiety."
		}
	],
	"Defend": [
		{
			"name": "assign_defence",
			"tags": ["Intent"],
			"subject": "self",
			"amount": null,
			"icon": null,
			"description": "A basic defence. Will give this Torment the specified amount of Perplexity."
		}
	],
}
