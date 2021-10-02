# Bosses and Elite entities use a special class which provides the
# setup_advanced() function. 
# This allows the advanced entity definitions to 
# have customized coding in them and their own scripts per name.
class_name AdvancedEnemyEntity
extends EnemyEntity


func setup_advanced(difficulty: String = "medium") -> void:
	# We expect an elite to have a defined const with its properties
	# called PROPERTIES, otheriwse their setup will fail
	var properties = get("PROPERTIES")
	setup(properties["name"], properties)
	# Not all advanced entities use the difficulty string
	# but we define it anyway.
	_properties["_difficulty"] = difficulty
