extends EnemyEntity

const BOSS_NAME := "Narcissus"
const HEALTH := 100
const TYPE := "Abuse"
const DAMAGE := 0
const SIZE := Vector2(160,160)
const ART = 'Caravaggio'
	
func setup_boss() -> void:
	canonical_name = BOSS_NAME
	name = BOSS_NAME
	health = HEALTH
	type = TYPE
	damage = DAMAGE
	entity_size = SIZE
	character_art = ART
