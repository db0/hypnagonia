extends Memory

func execute_memory_effect():
	var script = [
		{
			"name": "modify_properties",
			"tags": ["Card"],
			"set_properties": {"Tags": Terms.GENERIC_TAGS.frozen.name},
			"needs_subject": true,
			"subject": "tutor",
			"filter_state_tutor": [{
				"filter_cardfilters": [
					{
						"property": "Tags",
						"value": Terms.GENERIC_TAGS.frozen.name,
						"comparison": "ne",
					}
				],
			}],
			"subject_count": "all",
			SP.KEY_NEEDS_SELECTION: true,
			SP.KEY_SELECTION_COUNT: 1,
			SP.KEY_SELECTION_TYPE: "equal",
			SP.KEY_SELECTION_OPTIONAL: false,
			SP.KEY_SELECTION_IGNORE_SELF: true,
			"src_container": "hand",
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)
