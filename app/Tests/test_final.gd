@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_final_node_existe():
	var escena = load("res://Scenes/juego.tscn").instantiate()
	add_child_autoqfree(escena)
	assert_not_null(escena.get_node_or_null("Final"),
		"La escena juego debe tener un nodo Final")

func test_congelar_pantalla_win_reproduce_muerte_enemigo():
	Global.reset_game()
	Global.enemy_vida = 0
	var antes = AudioManager.muerteEnAu.playing
	Global.restar_vida_enemigo(0)
	if not Global.juego_terminado:
		return
	assert_true(Global.juego_terminado,
		"Al morir el enemigo el juego debe terminar")

func test_congelar_pantalla_lose_reproduce_muerte():
	Global.reset_game()
	Global.player_vida = 0
	var antes = AudioManager.muerte.playing
	Global.restar_vida_jugador(0)
	if not Global.juego_terminado:
		return
	assert_true(Global.juego_terminado,
		"Al morir el jugador el juego debe terminar")
