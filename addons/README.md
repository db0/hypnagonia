# Sound Manager Plugin
## Version 3.4
## Created by Celeste Privitera (@Xecestel) & Simón Olivo (@Sarturo)
## Licensed Under MIT License (see below)

Find the plugin on [itch.io](https://xecestel.itch.io/sound-manager-plugin)!

## Overview

The Sound Manager gives the users a better control over the audio of their games. Using this plugin, it is possible to play every sound of the game using just simple method calls. No more long AudioStreamPlayer lists inside your scenes nor long methods to handle the audio inside every script.  
  
This is a plugin designed to facilitate the Sound Manager Module configuration process, by offering an UI in the editor that makes its configuration easier.  
  
This plugin was created to:
- Automatically set the Sound Manager module scene as an autoload.
- Create a dock in the editor to make the configuration easier of the sound manager.
  
You can download this plugin from:
- [GitLab](https://gitlab.com/Xecestel/sound-manager)
- [itch.io](https://xecestel.itch.io/sound-manager-plugin)
- [Godot AssetLib](https://godotengine.org/asset-library/asset/361)
  
  
## Configuration

1.  Copy & paste the folder `sound_manager` in the `res://addons/` path from your project (this is the standard path for plugins in Godot).
2.  To activate/deactivate the plugin, go to `Project/Project Settings/Plugins`, locate the plugin entry and change its status.
3.  Once the plugin is activated, a dock called `SoundManager` will appear in the editor. Here you can change all the sounds settings, from default properties (volume, pitch) to AudioBus ("Master" is the fallback").
4.   Save the current scene (press the shortcut CTRL + S ).

The UI consists of three sections to facilitate the configuration and use of the sound manager.  
This UI:
- Allows you to change the default sound properties (volume and pitch) for each type of sound
- Allows you to set the audiobuses available in your project.
- Displays the sound files available in your resources.
- Allows you to easily build and edit the Audio FIles Dictionary.

Once set up, you can play/stop the sound files in any scene. To play the sounds you can use the "Audio_Files_Dictionary" ,  it allows you to use different strings (keys) for method calls and for the file names. This way, even if your audio file is called "*res://se_audio_jump.ogg*", you can set it in the dictionary to call it as a simple "Jump", adding a simple entry `"Jump" : "res://se_audio_jump.ogg"`.  
The dictionary is located inside the "SoundManager_config.gd" file, but you can just use the UI to edit it. You can place it wherever you want inside your project directory.  
Another way to play the sounds is to use the absolute path that leads to the file, like `SoundManager.play_bgm("res://Audio/BGM/background_music.ogg")`.  
  
The dock also comes with an additional button: `Advanced Options` to access some more options. The ones currently available are:
- `Preload resources`: setting this true will make the SoundManager load every audio file located on the given paths at its `_ready()`. Note that this may slow down game start, especially in projects with a long list of audio files, but will make sound playing faster.
- `Preinstantiate nodes`: you can tell the plugin to instantiate every node at startup. This will work in synergy with the "multiple sounds at once" feature for BGS, SE and ME. Note that this will make playing multiple sounds faster but may slow down games start and even the game itself, especially in bigger projects.
  
## Sound Types
The Sound Manager is able to manage 4 different sound types:
- BGM: background music, usually used to play and loop music on the background during scenes and gameplay
- BGS: background sound, usually used to play and loop sounds (like rain, or a crowd talking) on the background during scenes and gameplay
- SE: sound effects, usually used to play a short sound in certain moments during scenes or gameplay
- ME: music effects, usually used to play a short music in certain moments during scenes or gameplay (like a fanfare or a jingle)
Note that there is no practical difference between this sound types. The only difference between them are the AudioBusses used and the default sound type properties. This means that you can use them however you like and however you think it fits your game and workflow.  
  
## Methods
The methods you'll probably use the most are just 11, plus some useful setters and getters.  
**All methods of the Sound Manager are accessed from the singleton called "SoundManager".**  
  
### Sounds Handling
*The play method exists in 4 forms: `play_bgm`, `play_bgs`, `play_se` and `play_me`. They works at the same way*  
- `func play(audio : String, from_position : float = 0.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void`:  
this method lets you play the selected audio, passed as a string. If the audio is already playing, it will be restarted.  
The `audio` argument is the sound name. It can be an absolute path or the name you gave to the sound in the Audio Files Dictionary.  
The `from_position` argument allows you to choose where the sound is going to start playing from. It's a float value that represents the track position in seconds. Default is 0.0.  
`volume_db` and `pitch_scale` are respectively the values for the volume (in DB) and pitch for the sound track you want to play. If left to default the Sound Manager will just use the default settings you saved for that sound type from the dock.  
`sound_to_override` allows you to tell the module to not just play the sound, but to replace an already playing sound before doing that. If left blank, it will not do that and just play the new sound alongside the other.  

- `func stop(audio : String) -> void`:  
this method lets you stop the specified stream from playing. The argument should be the same name you used for the `play` method.

- `func find_sound(audio : String) -> int`:  
this method will return the index number of the sound you're looking for on the internal arrays used by the module. It will return -1 if the sound was not found.  

- `func is_playing(audio : String) -> bool`:  
this method returns `true` if the selected stream is plaiyng and `false` if not.

- `pause(sound : String) -> void`:  
this method allows you to pause a specified stream. Note that a paused sound is not a stopped one, so the method `is_playing` will still return `true`. 

- `unpause(sound : String) -> void`:  
this method allows you to unpause a specified stream.

- `set_paused(sound : String, paused : bool) -> void`:  
this method allows you to set if the stream is paused or not. Note that there's no difference between `set_paused(audio, true)` and `pause(audio)`, you can use the one you prefer.

- `is_paused(sound : String) -> bool`:  
this method returns `true` if the specified sound is paused.


### Getters and Setters
- `func get_playing_sounds() -> Array`:  
this method returns an array containing the names of the currently playing soundstreams.  
  
**The `set/get_volume_db/pitch_scale` methods exists in 4 forms respectively: `set/get_bgm/bgs/se/me_volume_db/pitch_scale`**
- `func set_volume_db(volume_db : float) -> void`:  
this method allows you to change the default value for the given sound type. `volume_db` is the volume in decibels. (`set_bgm_volume_db` for bgm)

- `func get_volume_db() -> float`:  
this method return the default volume for the given sound type. (`get_bgm_volume_db` for bgm)

- `func set_pitch_scale(pitch : float) -> void`:  
this method allows you to set the default pitch scale for the given sound type. (`set_bgm_pitch_scale` for bgm)

- `func get_pitch_scale() -> float`:  
this method returns the default pitch scale of the given sound type. (`get_bgm_pitch_scale` for bgm)  
  
**The following 4 methods are instead specific methods to change streams properties. They only exist in the specified form:**
- `func set_volume_db(volume_db : float, sound : String) -> void`:  
this method allows you to change the volume of the specified sound.

- `func get_volume_db(sound : String) -> float`:  
this method returns the volume of the specified sound. Returns -81.0 if the sound was not found.

- `func set_pitch_scale(pitch_scale : float, sound : String) -> void`:  
this method allows you to change the pitch scale of the specified sound.

- `func get_pitch_scale(sound : String) -> float`:  
this method returns the pitch scale of the specified sound. Returns -1.0 if the sound was not found.


- `func get_default_sound_properties(sound_type : String) -> Dictionary`:  
this method returns the default properties of the specified sound type.
The argument must be a string like `BGM`, `BGS`, `SE` and `ME`.
The return value will be a dictionary in the form of {`Volume` : `value`, `Pitch` : `value`}.

- `func set_sound_property(sound_type : String, property : String, value : float) -> void`:  
this method allows you to change the given property for the given sound type. Sound type must be one of `BGM`, `BGS`, `SE` or `ME`. Property must be either `Volume` or `Pitch`.

- `func get_audio_files_dictionary() -> Dictionary`:  
this method returns the Audio Files Dictionary.

- `func get_config_value(stream_name : String) -> String`:  
this method returns the file name of the given stream name. Returns `null` if an error occured.

- `func set_config_key(new_stream_name : String, new_stream_file : String) -> void`:  
this method allows the user to edit an existng value on the configuration dictionary, or add a new one in runtime. `new_stream_name` is the name of your choice for the stream (the key in the dictionary), while `new_stream_file` is the name of the file linked to it (the value in the dictionary).

- `func add_to_dictionary(audio_name : String, audio_file : String) -> void`:  
this method allows you to add a new voice to the dictionary in real time. `audio_name` is the name which you are going to call the audio with (the key in the Dictionary). `audio_file` is the file you want to play. It can be the file name (if the file is in the default audio dir path), or the absolute path for the file.

- `func is_preload_resources_enabled() -> bool`:  
this method returns true if the module has been set to preload resources. This method will also return false if you preload specific files from a list, as that doesn't ovveride the `Preload Resources` variable.

- `func enable_resource_preloading(enabled : bool = true) -> void`:  
this method allows you to enable resource preloading from script.


### Resource Preloading
There are also some useful methods to manage resource preloading:

- `func preload_resources_from_list(files_list : Array) -> void`:  
this method allows you to preload only a specific list of audio files. The content of the `files_list` array must be a recognizable sound name String, such as an absolute path, a sound name stored on the `Audio_Files_Dictionary` or even an already loaded sound `Resource`. This method is especially useful when you want to preload only certain sounds and not all of them, maybe because you know you will need them on the specific scene you're programming. Note that if the `Preload Resources` variable is enabled, this method will do nothing.

- `func preload_resources_from_path(path : String) -> void`:  
this method lets you preload every audio file located in a specific directory (passed via the `path` string argument). This is especially useful if you are using a different folder from the standard directory that you set on the dock for some audio files and want to preload them too without having to write a full list of files. This can be used alongside the automatic preload process.

- `func preload_resource(file : Resource) -> void`:  
this is mainly an internal method, but in any case you can still use it to preload a specific file. The `file` argument must be an already loaded sound `Resource`. You can basically see this method as a way to store a loaded resource to use it on the Sound Manager as you please. The module will store this variable linking it to the file name as it would do with any other preloaded resource, so to play the sound you just have to use the file name or the sound name you used on the Audio Files Dictionary.  

- `func preload_resource_from_string(file : String) -> void`:  
this is mainly an internal method, but in any case you can still use it to preload a specific file. For the `file` string argument rules, read the above rules about `files_list` array rules. Although this method exists and can be used, it's probably better to use the `preload_resources_from_list` method for almost any uses of this feature.  

- `func unload_all_resources(force_unload : bool = false) -> void`:  
this method allows you to unload every previously preloaded audio file. It's especially useful when used in combo with the `preload_resources_from_list` to unload at the end of a scene any resource you loaded at the start of the scene. The `force_unload` argument (default: `false`) will let you unload preloaded resources even if the `Preload Resources` variable is set to on. Note that this will unload **all** preloaded resources, so it basically overwrites the `Preload Resources` feature. If the `force_unload` argument is set to off, however, the method will do nothing if called while `Preload Resources` is on.

- `func unload_resources_from_list(files_list : Array) -> void`:  
this method allows you to pass a list of preloaded resources you want to unload. The files have to be Strings, but can be passed in any format (absolute path, file name, sound name). Note that thay can't be loaded Resources (why are you passing a loaded Resource if you want to unload it in the first place?)

- `func unload_resource_from_string(file : String) -> void`:  
this method allows you to unload a previously loaded resource passed by a string. The string can be passed in any format (absolute path, sound name, file name).

- `func unload_resources_from_dir(path : String) -> void`:  
this method lets you unload every audio file located in a specific directory (passed via the `path` string argument). This is especially useful if you preloaded a different folder from the standard directory that you set on the dock for some audio files and want to unload them too without having to write a full list of files. This can be used alongside the automatic preload process.
  
  
### Nodes Preinstantiation
There are also some useful methods to manage nodes preinstantiation:  

- `func preinstantiate_nodes_from_path(path : String, sound_type : String = "") -> void`:  
this method lets you preinstantiate every needed node on a specified directory (given its path). This can be used alongside the automatic preinstantiation process. You can also specify the `sound_type` (BGM, BGS, ME, SE) to allow the Sound Manager to automatically set the correct bus. If you don't, it will temporary use the "Master" bus until you play the sound for the first time. Then, it will update it.

- `func preinstantiate_nodes_from_list(files_list : Array, type_list : Array, all_same_type : bool = false) -> void`:  
this method allows you to pass a list of files you want to preinstantiate a node for. The files have to be Strings, but can be passed in any format (absolute path or sound name). Note: the `type_list` argument is used to tell the module which type does any sound you passed have. The indexes of the `type_list` must coincide with the indexes of the `files_list`.  If the `all_same_type` argument is passed as true, you can pass a single element array for the `type_list` implying that all the files you're passing are of the same sound type.

- `func preinstantiate_node_from_string(file : String, sound_type : String = "") -> void`:  
this method allows you to instantiate a node for a specific audio file passed by a string. The string can be passed in any format (absolute path or file name). The `sound_type` string is the type of the audio and must be either `BGM`, `BGS`, `SE` or `ME`. If left blank, the Sound Manager will use the "Master" bus for the node until you play it for the first time. Then, it will update it.

- `func preinstantiate_node(stream : Resource, sound_type : String = "") -> void`:  
this method allows you to instantiate a node for a specific audio file passed as an already loaded Resource. The file can be accessed afterwards with a sound name or a file name. The `sound_type` string is the type of the audio and must be either `BGM`, `BGS`, `SE` or `ME`. If left blank, the Sound Manager will use the "Master" bus for the node until you play it for the first time. Then, it will update it.

- `func uninstantiate_all_nodes(force_uninstantiation : bool = false) -> void`:  
this method allows you to uninstantiate every previously instantiated node. It's especially useful when used in combo with the `preinstantiate_nodes_from_list` to uninstantiate at the end of a scene any node you instantiated at the start of the scene. The `force_uninstantiation` argument (default: `false`) will let you uninstantiate nodes even if the `Preinstantiate Nodes` variable is set to on. Note that this will uninstantiate **all** instantiated resources, so it basically overwrites the `Preinstantiate Nodes` feature. If the `force_uninstantiation` argument is set to off, however, the method will do nothing if called while `Preinstantiate Nodes` is on.

- `func uninstantiate_nodes_from_list(files_list : Array) -> void`:  
this method allows you to pass a list of preinstantiated nodes you want to uninstantiate. The nodes have to be Strings, but can be passed in any format (absolute path or sound name).

- `func uninstantiate_node_from_string(file : String) -> void`:  
this method allows you to uninstantiate a previously instantiated node passed by a string. The string can be passed in any format (absolute path or file name).  

- `func uninstantiate_nodes_from_dir(path : String) -> void`:  
this method lets you uninstantiate every instantiated node based on a directory content (given its path). This is especially useful if you are using a different folder from the standard directory that you set on the dock for some audio files and want to uninstantiate them too without having to write a full list of files. This can be used alongside the automatic preinstantiation process. 

- `func enable_nodes_preinstantiation(enabled : bool = true) -> void`:  
this methods allows you to set the value on the `Preinstantiate Nodes` variable.

- `func is_preinstantiate_nodes_enabled() -> bool`:  
this method returns true if the module has been set to preinstantiate nodes. This method will also return false if you instantiate specific nodes from a list, as that doesn't ovveride the `Preinstantiate Nodes` variable.


## IMPORTANT NOTES:
For more information about how the Sound Manager Module works, read the [README](./addons/sound_manager/module/README.md) file inside the `module` directory.  
    
**Remember to add `*.json` files as to be exported on your export template, otherwhise the plugin may not work on the exported games.**  
  
If this docs wasn't enough for you to understand how this plugin works, or you just want to see it in action, check out the official [*Sound Manager Plugin Demo*](https://gitlab.com/Xecestel/sound-manager-demo).  
  
## Credits
The plugin was developed by Simón Olivo (@Sarturo) and Celeste Privitera (@Xecestel) as a derivative work from the [Sound Manager Module](./addons/sound_manager/module) originally developed by Celeste Privitera.  
  
Special thanks to @zaknafean for the efforts he made to help improve this plugin.  

## Licenses
### Sound Manager Module
Copyright © 2019-2021 Celeste Privitera  
  
The Sound Manager Module is subject to the terms of the MIT License.  
If a copy of the license was not distributed with this file, You can obtain one at [https://mit-license.org/](https://mit-license.org/).  

### Sound Manager Plugin
Copyright © 2019-2021 Simón Olivo & Celeste Privitera  

The Sound Manager Plugin is subject to the terms of the MIT License.  
If a copy of the license was not distributed with this file, You can obtain one at [https://mit-license.org/](https://mit-license.org/).  

## Changelog
### Version 1.3
- Now the plugin only loads audio files on the sound tabs
- Improved code readability a little bit

### Version 1.3.1
- Bug fixes

### Version 1.4
- Added advanced option button and resource preloading button.

### Version 1.5
- The resource preloading doesn't require the Audio File Dictionary anymore

### Version 1.6
- Added nodes preinstanting feature.

### Version 1.7
- Now the config file will not be reset at every update anymore.
- Bug fix

### Version 1.8
- Sound Manager Module has been updated to 2.3: now you can pass absolute paths to play sounds.
- Fixed bug that made the dock difficult to see on smaller screens.

### Version 1.8.1
- Bug fixes

### Version 1.9
- Improved preloading feature
- Improved absolute path passing feature
- Updated docs

### Version 1.9.1
- Improved manual preloading: now you can pass already loaded resources

### Version 1.9.2
- Bug fixes

### Version 1.9.3
- Bug fixes

### Version 1.9.4
- Bug fixes

### Version 1.10
- Added manual preinstantiation: now you can preinstantiate selected nodes
- Improved manual preloading
- Bug fixes and general improvements

### Version 1.10.1
- Bug fixes

### Version 1.11
- Sound Manager Module has been updated to 2.7: now you can add voices in the Audio Files Dictionary in runtime; now you can add in the Dictionary absolute paths as values

### Version 2.0
- Sound Manager Module has been updated to 3.0, making it compatible with Godot 3.2
- The plugin is now compatible with Godot 3.2 

### Version 2.1
- Fixed some bugs on preinstantiation and preloading of resources

### Version 3.0
- Remade the dock: removed the paths, removed alternative file tabs, added new buttons, changed look
- Refactored dock and plugin code: now they work with the new plugin design; improved code readability
- Improved dock design: added restore button on volume and pitch sliders; improved looks
- Improved dock code: improved some methods; improved readability
- Fixed bug that made the dock's files list empty when the plugin was enabled manually
- The Sound Manager Module has been reworked: now it doesn't differentiate anymore between sound types
- Updated Sounds script
- Improved readability following the [GDScript Style Guidelines](https://docs.godotengine.org/en/latest/getting_started/scripting/gdscript/gdscript_styleguide.html)

### Version 3.0.1
- Fixed a typo in plugin.cfg

### Version 3.0.2
- Minor improvements

### Version 3.0.3
- Fixed a bug in the dock script that prevented to add files on the Audio Files Dictionary

### Version 3.0.4
- Bug fixes
- Improved dock looks

### Version 3.0.5
- Bug fixed on dock

### Version 3.1
- Changed all SFX and MFX to SE and ME for consistency
- Fixed a bug that occurred when trying to play an instantiated sound chaning its properties from script

### Version 3.1.2
- Bug fixes
- Minor dock improvements

### Version 3.1.3
- Bug fix

### Version 3.1.4
- Bug fix

### Version 3.2
- Improved UI: now you can hide the file list panel when it's not needed, getting more space on the editor (thanks @zaknafean for the awesome help)
- Replaced the save icon on the dictionary panel
- Removed the `Add new entry` button from the dock, as it had no purpose anymore.
- Fixed a bug that made difficult to add multiple sounds in a row using the file list.

### Version 3.2.1
- General code improvements

### Version 3.2.2
- Updated module to 4.1.3: fixed a bug that occurred when stopping a sound and playing a new one on the same frame

### Version 3.3
- Added a Debug advanced option to be able to enable and disable the plugin debugging on the fly from the dock

### Version 3.4
- Fixed a bug that prevented the `is_playing()` method to work correctly when some nodes where preinstantiated
- Fixed a bug that in some cases prevented to manually stop a preinstantiated node
- Fixed a bug that prevented the plugin to run the `ready()` method correctly

### Version 3.4.1
- Added the method `play_deferred()` to automatically call the method `play` as deferred
- Possibly fixed a bug that occurred while fastly playing and stopping an audio stream multiple times

### Version 3.4.2
- Now the audio file panel on the dock can be scrolled horizontally when a file name is too long.
