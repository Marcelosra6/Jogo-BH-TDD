extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.reset_game()
	_setup_audio_buses()

func _setup_audio_buses():
	if AudioServer.get_bus_index("Music") == -1:
		AudioServer.add_bus(0)
		AudioServer.set_bus_name(0, "Music")
	if AudioServer.get_bus_index("SFX") == -1:
		AudioServer.add_bus(1)
		AudioServer.set_bus_name(1, "SFX")
	$Loop.bus = "Music"
	$Final.bus = "Music"
	
