extends Control

onready var owner_node = get_parent().get_parent()
var entity_art: Control

# Changes card highlight colour.
func set_highlight(requestedFocus: bool,
		hoverColour = CFConst.HOST_HOVER_COLOUR) -> void:
	if entity_art as TextureRect:
		if not requestedFocus:
			entity_art.material.set_shader_param(
					'width', 0.0)
			entity_art.material.set_shader_param(
					'color', CFConst.HOST_HOVER_COLOUR)
		else:
			entity_art.material.set_shader_param(
					'width', 30.0)
			entity_art.material.set_shader_param(
					'color', hoverColour)
	elif entity_art as AnimatedEnemy:
		entity_art.set_highlight(requestedFocus, hoverColour)

static func highlight_potential_card(colour : Color,
		potential_cards: Array,
		potential_slots := []) -> Card:
	potential_cards.sort_custom(CFUtils,"sort_index_ascending")
	for idx in range(0,len(potential_cards)):
			# The last card in the sorted array is always the highest index
		if idx == len(potential_cards) - 1:
			potential_cards[idx].highlight.set_highlight(true,colour)
		else:
			potential_cards[idx].highlight.set_highlight(false)
	for slot in potential_slots:
		slot.set_highlight(false)
	return(potential_cards.back())


static func highlight_potential_container(colour : Color,
		potential_containers: Array,
		potential_cards := [],
		potential_slots := []) -> CardContainer:
	potential_containers.sort_custom(CFUtils,"sort_card_containers")
	for idx in range(0,len(potential_containers)):
		if idx == len(potential_containers) - 1:
			potential_containers[idx].highlight.set_highlight(true,colour)
		else:
			potential_containers[idx].highlight.set_highlight(false)
	for card in potential_cards:
		card.highlight.set_highlight(false)
	for slot in potential_slots:
		slot.set_highlight(false)
	return(potential_containers.back())

