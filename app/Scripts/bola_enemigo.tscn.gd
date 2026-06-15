extends GutTest


func pre_run():
	Global.reset_game()


func test_jogador_global_position_igual_mouse_al_iniciar():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(100, 200))
	await get_tree().process_frame
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(100, 200),
		"Jogador deve estar na posicao do mouse")


func test_jogador_sigue_mouse_ao_mover():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(300, 400))
	await get_tree().process_frame
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(300, 400),
		"Jogador deve acompanhar o mouse ao mover")


func test_jogador_muda_posicao_continuamente():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	get_viewport().warp_mouse(Vector2(50, 60))
	await get_tree().process_frame
	jugador._process(0.016)
	get_viewport().warp_mouse(Vector2(200, 500))
	await get_tree().process_frame
	jugador._process(0.016)
	assert_eq(jugador.global_position, Vector2(200, 500),
		"Jogador deve atualizar posicao continuamente")
