class_name AddTagArtifact
extends ModifyPropertyArtifact

var tag_name: String

func _on_artifact_added() -> void:
	if not tag_name in Terms.get_all_tag_names():
		print_debug("ERROR: Tag name '%s' not known." % [tag_name])
		return
	card_filters.append(CardFilter.new('Tags', tag_name, 'ne'))
	property = 'Tags'
	new_value = tag_name
	._on_artifact_added()
