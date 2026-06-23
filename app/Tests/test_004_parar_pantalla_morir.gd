@tool
extends GutTest


func pre_run():
	Global.reset_game()


func test_congelar_pantalla_cambia_estado():
	Global.juego_terminado = false
	Global.congelar_pantalla("teste")
	assert_true(Global.juego_terminado,
		"pantalla congelada al terminar")


func test_jugador_muere():
	Global.reset_game()
	Global.player_vida = 1
	Global.restar_vida_jugador(1)
	assert_true(Global.juego_terminado,
		"juego_terminado debe ser true cuando se muere")


func test_restar_vida_jugador_no_altera_al_terminar():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.player_vida
	Global.restar_vida_jugador(1)
	assert_eq(Global.player_vida, vida_antes,
		"la vida no baja al terminar el juego")


func test_vida_jugador_disminuye_correctamente():
	Global.reset_game()
	var vida_inicial = Global.player_vida
	Global.restar_vida_jugador(2)
	assert_eq(Global.player_vida, vida_inicial - 2,
		"cantidad de disminución de vida correcta")
