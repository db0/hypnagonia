class_name KoboldAI
extends Reference


static func generate(prompt: String, max_length: int):
	var data := {
		"prompt": prompt,
		"frmttriminc": true,
		"use_memory": true,
		"use_world_info": true,
		"max_length": max_length,
		"disable_output_formatting": false,
	}
#	print("generate():" + str(data))
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


static func get_world_info():
	var ret = _initiate_rest(HTTPClient.METHOD_GET, "/api/latest/world_info")
	if ret:
		return(ret)


static func get_soft_prompt():
	var ret = _initiate_rest(HTTPClient.METHOD_GET, "/api/latest/config/soft_prompt")
	if ret:
		return(ret.value)


static func get_model():
	var ret = _initiate_rest(HTTPClient.METHOD_GET, "/api/latest/model")
	if ret:
		return(ret.result)


static func put_soft_prompt(sp_name : String):
	var data := {
		"value": sp_name,
	}
	var ret = _initiate_rest(HTTPClient.METHOD_PUT, "/api/latest/config/soft_prompt", data)
	if ret:
		return(ret)


static func put_story(story_name := "hypnagonia_koboldai_story"):
	var data := {
		"name": story_name,
	}
	var ret = _initiate_rest(HTTPClient.METHOD_PUT, "/api/latest/story/load",data)
	if ret:
		return(ret)


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
#	print([method, endpoint, data])
	var http = HTTPClient.new()
	# Connect to host/port.
	var err = http.connect_to_host(
			cfc.game_settings.get("kai_url",'http://127.0.0.1'), 
			cfc.game_settings.get("kai_port", 5000))
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
	if http.get_status() != HTTPClient.STATUS_CONNECTED:
		push_error("Could not connect to KoboldAI Server.")
		return
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
