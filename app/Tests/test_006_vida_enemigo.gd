extends GutTest


func pre_run():
	Global.reset_game()


func test_restar_vida_enemigo_diminui_corretamente():
	Global.reset_game()
	var vida_inicial = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_inicial - 100,
		"enemy_vida deve diminuir 100")


func test_restar_vida_enemigo_multiplas_vezes():
	Global.reset_game()
	Global.restar_vida_enemigo(100)
	Global.restar_vida_enemigo(200)
	Global.restar_vida_enemigo(300)
	assert_eq(Global.enemy_vida, Global.enemy_vida,
		"vida deve acumular subtracoes")


func test_enemigo_nao_morre_com_vida_positiva():
	Global.reset_game()
	Global.restar_vida_enemigo(100)
	assert_false(Global.juego_terminado,
		"juego_terminado deve ser false se inimigo tem vida")


func test_enemigo_morre_quando_vida_chega_zero():
	Global.reset_game()
	Global.enemy_vida = 50
	Global.restar_vida_enemigo(50)
	assert_true(Global.juego_terminado,
		"juego_terminado deve ser true quando inimigo morre")


func test_enemigo_morre_com_dano_exato():
	Global.reset_game()
	var dano_necessario = Global.enemy_vida
	Global.restar_vida_enemigo(dano_necessario)
	assert_true(Global.juego_terminado,
		"inimigo deve morrer com dano exato igual a vida total")


func test_restar_vida_enemigo_nao_afeta_se_juego_terminado():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_antes,
		"vida do inimigo nao deve mudar se jogo ja terminou")
