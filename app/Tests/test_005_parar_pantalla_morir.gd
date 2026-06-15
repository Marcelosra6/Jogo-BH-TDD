extends GutTest


func pre_run():
	Global.reset_game()


func test_congelar_pantalla_muda_estado():
	Global.juego_terminado = false
	Global.congelar_pantalla("teste")
	assert_true(Global.juego_terminado,
		"juego_terminado deve ser true apos congelar_pantalla")


func test_jugador_muere_quando_vida_chega_zero():
	Global.reset_game()
	Global.player_vida = 1
	Global.restar_vida_jugador(1)
	assert_true(Global.juego_terminado,
		"juego_terminado deve ser true quando jogador morre")


func test_jugador_nao_morre_com_vida_positiva():
	Global.reset_game()
	Global.restar_vida_jugador(1)
	assert_false(Global.juego_terminado,
		"juego_terminado deve ser false se jogador ainda tem vida")


func test_restar_vida_jugador_nao_afeta_se_juego_terminado():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.player_vida
	Global.restar_vida_jugador(1)
	assert_eq(Global.player_vida, vida_antes,
		"vida nao deve mudar se jogo ja terminou")


func test_vida_jugador_diminui_corretamente():
	Global.reset_game()
	var vida_inicial = Global.player_vida
	Global.restar_vida_jugador(2)
	assert_eq(Global.player_vida, vida_inicial - 2,
		"vida do jogador deve diminuir pela quantidade correta")
