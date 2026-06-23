@tool
extends GutTest

var escenaJugador = preload("res://Scenes/jogador.tscn")

func pre_run():
	Global.reset_game()

func test_jugador_sigue_mouse():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(300, 400))
	await wait_process_frames(3)
	jugador._process(0.016)
	var mouse = get_viewport().get_mouse_position()
	assert_almost_eq(jugador.global_position.x, mouse.x, 2.0,
		"El jugador debe seguir al mouse en X")
	assert_almost_eq(jugador.global_position.y, mouse.y, 2.0,
		"El jugador debe seguir al mouse en Y")

func test_jugador_actualiza_posicion_continuamente():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(50, 60))
	await wait_process_frames(2)
	jugador._process(0.016)
	var pos1 = jugador.global_position
	get_viewport().warp_mouse(Vector2(200, 500))
	await wait_process_frames(2)
	jugador._process(0.016)
	var pos2 = jugador.global_position
	assert_true(pos1.distance_to(pos2) > 5.0,
		"El jugador debe actualizar su posición al moverse el mouse")
		
func test_input_actions_existen():
	assert_has(InputMap.get_actions(), "left")
	assert_has(InputMap.get_actions(), "right")
	assert_has(InputMap.get_actions(), "up")
	assert_has(InputMap.get_actions(), "down")
	assert_has(InputMap.get_actions(), "fire")

func test_movimiento_izquierda_con_tecla():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var x_anterior = jugador.global_position.x
	Input.action_press("left")
	jugador._process(0.016)
	Input.action_release("left")
	assert_lt(jugador.global_position.x, x_anterior,
		"jogador debe moverse a la izquierda con left")

func test_movimiento_derecha_con_tecla():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var x_anterior = jugador.global_position.x
	Input.action_press("right")
	jugador._process(0.016)
	Input.action_release("right")
	assert_gt(jugador.global_position.x, x_anterior,
		"jogador debe moverse a la derecha con right")

func test_movimiento_arriba_con_tecla():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var y_anterior = jugador.global_position.y
	Input.action_press("up")
	jugador._process(0.016)
	Input.action_release("up")
	assert_lt(jugador.global_position.y, y_anterior,
		"jogador debe moverse arriba con up")

func test_movimiento_abajo_con_tecla():
	var jugador = escenaJugador.instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var y_anterior = jugador.global_position.y
	Input.action_press("down")
	jugador._process(0.016)
	Input.action_release("down")
	assert_gt(jugador.global_position.y, y_anterior,
		"jogador debe moverse abajo con down")

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

func test_disparo_con_espacio():
	var jugador = escenaJugador.instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	Input.action_press("fire")
	jugador._process(0.016)
	Input.action_release("fire")
	for i in range(padre.get_child_count()):
		var hijo = padre.get_child(i)
		if hijo.is_in_group("Bala"):
			assert_true(hijo is Area2D,
				"debe crear una bala al presionar espacio")
			return
	assert_eq(padre.get_child_count(), 2,
		"debe haber 2 hijos (jugador + 1 bala) al disparar con espacio")

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
