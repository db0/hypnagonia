class_name AIRatings
extends Node

signal ratings_retrieved(ratings_dict, evaluating)

const TELEMETRY_URI := "http://dbzer0.com"
const TELEMETRY_PORT := 8000
#const TELEMETRY_URI := "http://127.0.0.1"

# In case this node is going to be used to submit stories, 
# we need to know the encounter to submit
var encounter: EncounterStory
# In case this node is going to be used to submit stories, 
# we need to know the type of fluff this is. This should be coming from the parent node
var threads: Array

func _init(_encounter: EncounterStory = null):
	encounter = _encounter


func story_rated(classification :int) -> void:
	# If the player didn't like it, we don't bother sending it at all
	if classification == HConst.AIGenres.DISLIKE:
		return
	var thread: Thread = Thread.new()
	threads.append(thread)
# warning-ignore:return_value_discarded
	thread.start(self, "submit", classification)


func submit(classification: int):
	var data := {
		"uuid": encounter.story_uuid,
		"generation": encounter.story,
		"title": encounter.title,
		"type": encounter.type,
		"classification": classification,
		"client_id": cfc.game_settings['Client UUID'],
		"model": globals.ai_stories.current_model,
		"soft_prompt": globals.ai_stories.current_soft_prompt,
		"kai_instance": "%s:%s" % [cfc.game_settings.get("kai_url",'http://127.0.0.1'),cfc.game_settings.get("kai_port", 5000)],
	}
	var _ret = _initiate_rest(HTTPClient.METHOD_POST, "/generation/", data)


func retrieve_evaluating_gens() -> void:
	var thread: Thread = Thread.new()
	threads.append(thread)
# warning-ignore:return_value_discarded
	thread.start(self, "retrieve_gens", true)


func retrieve_finalized_gens() -> void:
	var thread: Thread = Thread.new()
	threads.append(thread)
# warning-ignore:return_value_discarded
	thread.start(self, "retrieve_gens", false)


func retrieve_gens(evaluating:= true) -> void:
	var endpoint = "/generations/evaluating/"
	if not evaluating:
		endpoint = "/generations/finalized/"
	var ret = _initiate_rest(HTTPClient.METHOD_GET, endpoint)
	if typeof(ret) == TYPE_DICTIONARY:
		emit_signal("ratings_retrieved", ret, evaluating)
	else:
		var blah = endpoint.replace("/generations/",'').replace("/",'')
		CFUtils.dprint("AIRatings:Could not retrieve %s stories from %s:%s" % [blah,TELEMETRY_URI,TELEMETRY_PORT])


func _initiate_rest(method, endpoint: String, data: Dictionary = {}):
	var http = HTTPClient.new()
	# Connect to host/port.
	var err = http.connect_to_host(TELEMETRY_URI, TELEMETRY_PORT)
	# Make sure connection was OK.
	assert(err == OK)
	# Wait until resolved and connected.
	while http.get_status() == HTTPClient.STATUS_CONNECTING\
			or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		if not OS.has_feature("web"):
			OS.delay_msec(500)
		else:
			# Synchronous HTTP requests are not supported on the web,
			# so wait for the next main loop iteration.
			yield(Engine.get_main_loop(), "idle_frame")


	# Could not connect
	assert(http.get_status() == HTTPClient.STATUS_CONNECTED)
	var headers = ["Content-Type: application/json"]
	var query = JSON.print(data)
	err = http.request(method, endpoint, headers, query)
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling for as long as the request is being processed.
		http.poll()
		if not OS.has_feature("web"):
			OS.delay_msec(500)
		else:
			# Synchronous HTTP requests are not supported on the web,
			# so wait for the next main loop iteration.
			yield(Engine.get_main_loop(), "idle_frame")
	# Make sure request finished well.
	assert(http.get_status() == HTTPClient.STATUS_BODY\
			or http.get_status() == HTTPClient.STATUS_CONNECTED)
	if http.has_response():
		# If there is a response...
		headers = http.get_response_headers_as_dictionary() # Get response headers.
#		print_debug("**headers:\\n", headers) # Show headers.
		if http.get_response_code() in [200, 204]:
			# Array that will hold the data.
			var rb = PoolByteArray()
			while http.get_status() == HTTPClient.STATUS_BODY:
				# While there is body left to be read
				http.poll()
				# Get a chunk.
				var chunk = http.read_response_body_chunk()
				if chunk.size() == 0:
					if not OS.has_feature("web"):
						# Got nothing, wait for buffers to fill a bit.
						OS.delay_usec(1000)
					else:
						# Synchronous HTTP requests are not supported on the web,
						# so wait for the next main loop iteration.
						yield(Engine.get_main_loop(), "idle_frame")
				else:
					# Append to read buffer.
					rb = rb + chunk
			var results = rb.get_string_from_ascii()
			var p = JSON.parse(results)
			if typeof(p.result) == TYPE_DICTIONARY:
				return(p.result)
			else:
				push_error("Unexpected results.")
		else:
			push_error("Unexpected HTTP Return:" + str(http.get_response_code()))
