@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_escena_pausa_existe():
	var escena = load("res://Scenes/pausa.tscn")
	assert_not_null(escena, "pausa.tscn debe existir y cargarse")
	var instancia = escena.instantiate()
	add_child_autoqfree(instancia)
	assert_not_null(instancia, "La escena pausa debe instanciarse")

func test_pausa_empieza_oculta():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	assert_false(pausa.visible, "pausa debe estar oculta al iniciar")

func test_pausa_procesa_siempre():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	assert_eq(pausa.process_mode, PROCESS_MODE_ALWAYS,
		"pausa debe tener process_mode ALWAYS")

func test_pausa_se_muestra_al_pausar():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	get_tree().paused = false
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = true
	pausa._unhandled_input(event)
	assert_true(get_tree().paused, "pausa debe pausar el arbol")
	assert_true(pausa.visible, "pausa debe mostrarse al pausar")

func test_pausa_alterna_estado():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	get_tree().paused = false
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = true
	pausa._unhandled_input(event)
	assert_true(get_tree().paused, "primera vez pausa el arbol")
	assert_true(pausa.visible, "primera vez muestra pausa")
	pausa._unhandled_input(event)
	assert_false(get_tree().paused, "segunda vez despausa el arbol")
	assert_false(pausa.visible, "segunda vez oculta pausa")

func test_pausa_no_funciona_si_juego_terminado():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	Global.juego_terminado = true
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = true
	pausa._unhandled_input(event)
	assert_false(get_tree().paused,
		"pausa no debe activarse cuando juego_terminado es true")

func test_pausa_tiene_color_rect():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	assert_not_null(pausa.get_node_or_null("ColorRect"),
		"pausa debe tener un ColorRect para el overlay")

func test_pausa_tiene_label():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	assert_not_null(pausa.get_node_or_null("Label"),
		"pausa debe tener un Label con texto de pausa")
