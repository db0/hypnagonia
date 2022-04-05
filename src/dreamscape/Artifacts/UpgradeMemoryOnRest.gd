extends Artifact

func setup(signifier_details: Dictionary, signifier_name: String):
	.setup(signifier_details,signifier_name)
	update_amount(artifact_object.counter)
	if artifact_object.counter >= ArtifactDefinitions.UpgradeMemoryOnRest.max_uses:
		_activate()
