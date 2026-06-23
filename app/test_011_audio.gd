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

func test_disparar_respeta_cadencia():
	var jugador = escenaJugador.instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	jugador.disparar()
	var cantidad_despues_primer_disparo = padre.get_child_count()
	jugador.timer_disparo = jugador.cadencia
	jugador._process(0.01)
	assert_eq(padre.get_child_count(), cantidad_despues_primer_disparo,
		"No debe disparar si timer_disparo aún no llega a 0")

func test_timer_disparo_se_reinicia_a_cadencia_al_disparar():
	var jugador = escenaJugador.instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	jugador.disparar()
	jugador.timer_disparo = jugador.cadencia
	assert_eq(jugador.timer_disparo, jugador.cadencia,
		"timer_disparo debe reiniciarse a cadencia tras disparar")
