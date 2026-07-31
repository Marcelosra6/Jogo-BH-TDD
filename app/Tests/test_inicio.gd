@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_escena_inicio_existe():
	var escena = load("res://Scenes/inicio.tscn")
	assert_not_null(escena, "inicio.tscn debe existir y cargarse")
	var instancia = escena.instantiate()
	add_child_autoqfree(instancia)
	assert_not_null(instancia, "La escena inicio debe instanciarse")

func test_boton_jugar_tiene_script():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button", true, false)
	assert_not_null(btn, "Debe existir un Button JUGAR")
	assert_not_null(btn.get_script(), "btnJugar debe tener un script")
	assert_true(btn.has_method("_on_pressed"), "btnJugar debe tener metodo _on_pressed")
func test_boton_salir_tiene_script():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button2", true, false)
	assert_not_null(btn, "Debe existir un Button SALIR")
	assert_not_null(btn.get_script(), "btnSalir debe tener un script")
	assert_true(btn.has_method("_on_pressed"), "btnSalir debe tener metodo _on_pressed")

func test_boton_jugar_texto():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button", true, false)
	assert_eq(btn.text, "JUGAR", "El boton debe decir JUGAR")

func test_boton_salir_texto():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button2", true, false)
	assert_eq(btn.text, "SALIR", "El boton debe decir SALIR")

func test_inicio_tiene_camera():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	assert_not_null(escena.find_child("Camera2D", true, false),
		"inicio debe tener una Camera2D")

func test_inicio_tiene_fondo():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	assert_not_null(escena.find_child("fondoIni", true, false),
		"inicio debe tener un Sprite2D de fondo")

func test_inicio_tiene_vbox():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	assert_not_null(escena.find_child("VBoxContainer", true, false),
		"inicio debe tener un VBoxContainer con los botones")
