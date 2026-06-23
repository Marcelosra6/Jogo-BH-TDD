@tool
extends GutTest

var escenaJugador = preload("res://Scenes/jogador.tscn")
var escenaBala = preload("res://bala.tscn")

func pre_run():
	Global.reset_game()

func test_disparar_instancia_bala_en_el_padre():
	var jugador = escenaJugador.instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	var cantidad_antes = padre.get_child_count()
	jugador.disparar()
	assert_eq(padre.get_child_count(), cantidad_antes + 1,
		"Debe crear 1 bala en el padre al disparar")

func test_bala_posicion_igual_jugador_al_disparar():
	var jugador = escenaJugador.instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	jugador.global_position = Vector2(150, 300)
	jugador.disparar()
	var bala = padre.get_child(padre.get_child_count() - 1)
	assert_eq(bala.global_position, Vector2(150, 300),
		"La bala debe aparecer en la posición global del jugador")

func test_bala_movimiento_hacia_arriba():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	bala._process(0.016)
	assert_lt(bala.global_position.y, 500,
		"La bala debe moverse hacia arriba (y disminuyendo)")

func test_bala_sube_cada_frame():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	var y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"La bala debe subir en cada frame")
	y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"La bala debe continuar subiendo en el segundo frame")
