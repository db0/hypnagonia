class_name SubmitRatings
extends Node


const TELEMETRY_URI := "http://127.0.0.1"
const TELEMETRY_PORT := 8000

var encounter: SingleEncounter
# The type of fluff this is. This should be coming from the parent node
var type: String
var thread: Thread

func _init(_encounter: SingleEncounter, _type: String):
	encounter = _encounter
	type = _type


func story_rated(liked :int) -> void:
	var desc = "Liked"
	if not liked:
		desc = "Disliked"
	print_debug(desc + " Story: "+ encounter.description_uuid)
	var thread: Thread = Thread.new()
	thread.start(self, "submit", liked)


#        parser.add_argument("uuid", type=str, required=True, help="UUID of the generation")
#        parser.add_argument("generation", type=str, required=True, help="Content of the generattion")
#        parser.add_argument("title", type=str, required=True, help="The name of the thing for which we're generating")
#        parser.add_argument("type", type=str, required=True, help="The type of generation it is. This is used for finding previous such generations")
#        parser.add_argument("liked", type=bool, required=True, help="True if the user liked it, False if they did not.")
#        parser.add_argument("client_id", type=str, required=True, help="The unique ID for this version of Hypnagonia client")

func submit(classification: int):
	var data := {
		"uuid": encounter.description_uuid,
		"generation": encounter.description,
		"title": encounter.title,
		"type": type,
		"classification": classification,
		"client_id": cfc.game_settings['Client UUID'],
	}
	print_debug(data)
#	print("generate():" + prompt)
#	print("generate():" + str(data))
#	print(data)
	var ret = _initiate_rest(HTTPClient.METHOD_POST, "/generation/", data)

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
