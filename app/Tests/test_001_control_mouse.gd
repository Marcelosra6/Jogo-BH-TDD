@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_jugador_posicion_global_igual_mouse_al_iniciar():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(100, 200))
	await wait_process_frames(2)
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(100, 200),
		"El jugador debe estar en la posición del mouse")

func test_jugador_sigue_mouse_al_mover():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(300, 400))
	await wait_process_frames(2)
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(300, 400),
		"El jugador debe seguir al mouse al moverse")

func test_jugador_actualiza_posicion_continuamente():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(50, 60))
	await get_tree().process_frame
	jugador._process(0.016)
	get_viewport().warp_mouse(Vector2(200, 500))
	await get_tree().process_frame
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(200, 500),
		"El jugador debe actualizar su posición continuamente")
