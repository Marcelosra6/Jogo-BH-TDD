@tool
extends GutTest


func pre_run():
	Global.reset_game()


func test_restar_vida_enemigo_diminuye_corretamente():
	Global.reset_game()
	var vida_inicial = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_inicial - 100,
		"enemy_vida debe disminuir en 100")


func test_restar_vida_enemigo_varias_veces():
	Global.reset_game()
	Global.restar_vida_enemigo(100)
	Global.restar_vida_enemigo(200)
	Global.restar_vida_enemigo(300)
	assert_eq(Global.enemy_vida, Global.enemy_vida,
		"vida debe acumular las sustracciones")


func test_enemigo_no_muere_con_vida():
	Global.reset_game()
	Global.restar_vida_enemigo(100)
	assert_false(Global.juego_terminado,
		"juego_terminado debe ser false con vida positiva")


func test_enemigo_muere():
	Global.reset_game()
	Global.enemy_vida = 50
	Global.restar_vida_enemigo(50)
	assert_true(Global.juego_terminado,
		"juego_terminado al morir el enemigo")


func test_restar_vida_enemigo_no_afecta_juego_terminado():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_antes,
		"la vida del enemigo no baja al terminar el juego")
