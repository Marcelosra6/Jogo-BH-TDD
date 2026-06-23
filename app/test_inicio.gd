@tool
extends GutTest

func test_boton_jugar_funciona():
	var pantalla = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(pantalla)
	var boton = pantalla.get_node_or_null("BotonJugar")
	assert_not_null(boton, "BotonJugar debe existir")
	boton.emit_signal("pressed")
	assert_eq(get_tree().current_scene.name, "Juego",
		"Al presionar Jugar debe cargar la escena del juego")

func test_boton_salir_funciona():
	var pantalla = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(pantalla)
	var boton = pantalla.get_node_or_null("BotonSalir")
	assert_not_null(boton, "BotonSalir debe existir")
	boton.emit_signal("pressed")
	assert_true(pantalla.is_queued_for_deletion() or not pantalla.is_inside_tree(),
		"Al presionar Salir la pantalla debe cerrarse o el árbol debe limpiarse")
