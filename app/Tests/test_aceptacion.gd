@tool
extends GutTest
 
func before_each():
	Global.reset_game()
 
func test_rf1_inicio_juego():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button", true, false)
	assert_not_null(btn, "RF1: Debe existir boton JUGAR en el menu principal")
	assert_eq(btn.text, "JUGAR", "RF1: El boton debe decir JUGAR")
	assert_true(btn.has_method("_on_pressed"), "RF1: btnJugar debe cambiar a juego.tscn")
 
func test_rf2_pausa_juego():
	var pausa = load("res://Scenes/pausa.tscn").instantiate()
	add_child_autoqfree(pausa)
	pausa._ready()
	assert_eq(pausa.process_mode, PROCESS_MODE_ALWAYS,
		"RF2: Pausa debe procesar incluso cuando el arbol esta pausado")
	get_tree().paused = false
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = true
	pausa._unhandled_input(event)
	assert_true(get_tree().paused, "RF2: Presionar H debe pausar el juego")
	assert_true(pausa.visible, "RF2: La pantalla de pausa debe mostrarse")
	pausa._unhandled_input(event)
	assert_false(get_tree().paused, "RF2: Presionar H otra vez debe reanudar el juego")
	assert_false(pausa.visible, "RF2: La pantalla de pausa debe ocultarse al reanudar")
 
func test_rf3_cierre_juego():
	var escena = load("res://Scenes/inicio.tscn").instantiate()
	add_child_autoqfree(escena)
	var btn = escena.find_child("Button2", true, false)
	assert_not_null(btn, "RF3: Debe existir boton SALIR en el menu principal")
	assert_eq(btn.text, "SALIR", "RF3: El boton debe decir SALIR")
	assert_true(btn.has_method("_on_pressed"), "RF3: btnSalir debe cerrar la aplicacion")
 
func test_rf4_interaccion_personaje():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	var pos_ini = jugador.global_position
	Input.action_press("right")
	jugador._process(0.016)
	Input.action_release("right")
	assert_gt(jugador.global_position.x, pos_ini.x,
		"RF4: El jugador debe moverse a la derecha con la tecla D/flecha derecha")
	jugador.disparar()
	assert_eq(padre.get_child_count(), 2,
		"RF4: Al disparar debe crearse una bala en el padre")
	var bala = padre.get_child(1)
	assert_not_null(bala.get_script(), "RF4: La bala debe tener un script de movimiento")
 
func test_rf5_interaccion_enemigo():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	add_child_autoqfree(enemigo)
	enemigo._ready()
	var pos_ini = enemigo.position
	enemigo._process(0.016)
	assert_ne(enemigo.position, pos_ini,
		"RF5: El enemigo debe moverse autonomamente cada frame")
	enemigo._process(0.016)
	assert_ne(enemigo.position, pos_ini,
		"RF5: El movimiento del enemigo debe ser continuo")
 
func test_rf6_variedad_disparos_enemigo():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	assert_true(enemigo.has_method("disparo1"), "RF6: El enemigo debe tener disparo1 (abanico)")
	assert_true(enemigo.has_method("disparo2"), "RF6: El enemigo debe tener disparo2 (circulo)")
	assert_true(enemigo.has_method("disparo3"), "RF6: El enemigo debe tener disparo3 (bolas)")
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	enemigo.disparo2()
	await get_tree().process_frame
	assert_eq(padre.get_child_count(), 61,
		"RF6: disparo2 debe crear 100 balas en el padre")
 
func test_rf7_dano_enemigo():
	var bala = load("res://bala.tscn").instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.enemy_vida
	var area_enemigo = Area2D.new()
	var nodo_enemigo = Node2D.new()
	nodo_enemigo.name = "Enemigo"
	nodo_enemigo.add_child(area_enemigo)
	add_child_autoqfree(nodo_enemigo)
	bala._on_area_2d_area_entered(area_enemigo)
	assert_eq(Global.enemy_vida, vida_antes - 100,
		"RF7: Las balas del jugador deben restar 100 de vida al enemigo")
	assert_true(bala.is_queued_for_deletion(),
		"RF7: La bala debe eliminarse al impactar al enemigo")
 
func test_rf8_recibir_dano_y_morir():
	var bala = load("res://bala_enemigo.tscn").instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.player_vida
	var area_jugador = Area2D.new()
	var nodo_jugador = Node2D.new()
	nodo_jugador.name = "Jogador"
	nodo_jugador.add_child(area_jugador)
	add_child_autoqfree(nodo_jugador)
	bala._on_area_2d_area_entered(area_jugador)
	assert_eq(Global.player_vida, vida_antes - 1,
		"RF8: Los proyectiles enemigos deben restar 1 de vida al jugador")
	assert_true(bala.is_queued_for_deletion(),
		"RF8: El proyectil debe eliminarse al impactar")
	Global.reset_game()
	Global.player_vida = 1
	Global.restar_vida_jugador(1)
	assert_true(Global.juego_terminado,
		"RF8: Si la salud del jugador llega a 0, el juego debe terminar")
