# This is just a constant which preloads all card images which are used in the game
# This is to avoid loading files during runtime and to be able to easier map filenames
# to card names.
class_name ImageLibrary
extends Reference

const CARD_IMAGES := {
	"Catatonia": preload("res://assets/cards/Catatonia.jpg"),
	"Could Be Worse": preload("res://assets/cards/Could Be Worse.jpg"),
	"Dismissal": preload("res://assets/cards/Dismissal.jpg"),
	"Eureka!": preload("res://assets/cards/Eureka!.jpg"),
	"Hyperfocus": preload("res://assets/cards/Hyperfocus.jpg"),
	"Inner Justice": preload("res://assets/cards/Inner Justice.jpg"),
	"Interpretation": preload("res://assets/cards/Interpretation.jpg"),
	"Is it my fault?": preload("res://assets/cards/Is It My Fault.jpg"),
	"Lash-out": preload("res://assets/cards/Lash-Out.jpg"),
	"Prejudice": preload("res://assets/cards/Prejudice.jpg"),
	"Rancor": preload("res://assets/cards/Rancor.jpg"),
	"Rapid Theorizing": preload("res://assets/cards/Rapid Theorizing.jpg"),
	"Self-Deception": preload("res://assets/cards/Self-Deception.jpg"),
	"The Happy Place": preload("res://assets/cards/The Happy Place.jpg"),
	"Tolerance": preload("res://assets/cards/Tolerance.jpg"),
	"Introspection": preload("res://assets/cards/Introspection.jpg"),
	"Change of Mind": preload("res://assets/cards/Change of Mind.jpg"),
	"Misunderstood": preload("res://assets/cards/Misunderstood.jpg"),
}
