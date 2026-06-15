extends GutTest


func pre_run():
	Global.reset_game()


func test_enemigo_muerte_congela_pantalla():
	Global.reset_game()
	Global.enemy_vida = 0
	Global.restar_vida_enemigo(0)
	assert_true(Global.juego_terminado,
		"juego_terminado deve ser true quando inimigo morre")


func test_congelar_pantalla_llamado_al_morir_enemigo():
	Global.reset_game()
	var mensaje_capturado = ""
	watch_signals(Global)
	Global.enemy_vida = 50
	Global.restar_vida_enemigo(50)
	assert_true(Global.juego_terminado,
		"deve ativar juego_terminado ao matar inimigo")


func test_reset_game_restaura_vida_inimigo():
	Global.reset_game()
	Global.enemy_vida = 0
	Global.reset_game()
	assert_eq(Global.enemy_vida, 10000.0,
		"reset_game deve restaurar vida do inimigo para 10000")


func test_juego_terminado_evita_dano_enemigo():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_antes,
		"vida do inimigo nao deve mudar se jogo terminou")
