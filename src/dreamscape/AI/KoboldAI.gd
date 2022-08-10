class_name KoboldAI
extends Reference

enum GenerationTypes {
	TORMENT_INTRO
	TORMENT_TAUNT
}

const DEFAULTS := {
	GenerationTypes.TORMENT_INTRO: {
		"max_length": 80
	},
	GenerationTypes.TORMENT_TAUNT: {
		"max_length": 40
	}
}

const KAI_URI := "http://127.0.0.1"
const KAI_PORT := 5000


static func generate(prompt: String, gentype: int):
	var data := {
		"prompt": prompt,
		"use_memory": true,
	}
#	print("generate():" + prompt)
	for k in DEFAULTS[gentype]:
		data[k] = DEFAULTS[gentype][k]
	print("generate():" + str(data))
#	print(data)
	var ret = _initiate_rest(HTTPClient.METHOD_POST, "/api/latest/generate/", data)
	if ret:
		return(ret.results[0].text)


static func get_gui_story():
	var ret = _initiate_rest(HTTPClient.METHOD_GET, "/api/latest/story")
	if ret:
		return(ret.results)


static func get_story():
	var ret = _initiate_rest(HTTPClient.METHOD_GET, "/api/latest/config/memory")
	if ret:
		return(ret.value)


static func put_memory(value: String):
	var data := {
		"value": value,
	}
	var ret = _initiate_rest(HTTPClient.METHOD_PUT, "/api/latest/config/memory", data)
	if ret:
		return(ret.value)


static func post_gui_story(prompt: String):
	var data := {
		"prompt": prompt,
	}
	var ret = _initiate_rest(HTTPClient.METHOD_POST, "/api/latest/story/end", data)
	if ret:
		return(ret.result.text)


static func _initiate_rest(method, endpoint: String, data: Dictionary = {}):
	var http = HTTPClient.new()
	# Connect to host/port.
	var err = http.connect_to_host(KAI_URI, KAI_PORT)
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
		if http.get_response_code() == 200:
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
