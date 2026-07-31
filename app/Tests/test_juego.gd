@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_escena_juego_existe():
	var escena = load("res://Scenes/juego.tscn")
	assert_not_null(escena, "juego.tscn debe existir y cargarse")
	var instancia = escena.instantiate()
	add_child_autoqfree(instancia)
	assert_not_null(instancia, "La escena juego debe instanciarse")
	assert_true(instancia.get_script() != null, "La escena juego debe tener un script")

func test_audio_buses_creados():
	var master_index = AudioServer.get_bus_index("Master")
	assert_ne(master_index, -1, "El bus Master debe existir siempre")
	
func test_mouse_mode_oculto():
	var escena = load("res://Scenes/juego.tscn").instantiate()
	add_child_autoqfree(escena)
	escena._ready()
	assert_eq(Input.get_mouse_mode(), Input.MOUSE_MODE_HIDDEN,
		"El mouse debe estar oculto al iniciar el juego")
