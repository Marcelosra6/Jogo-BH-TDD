@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_script_global_existe():
	assert_not_null(Global, "Global debe ser un autoload accesible")
	assert_true("player_vida" in Global, "Global debe tener player_vida")
	assert_true("enemy_vida" in Global, "Global debe tener enemy_vida")
	assert_true("juego_terminado" in Global, "Global debe tener juego_terminado")

func test_reset_game_valores_iniciales():
	Global.reset_game()
	assert_eq(Global.player_vida, Global.max_player_vida,
		"reset_game debe restaurar player_vida al máximo")
	assert_eq(Global.enemy_vida, 10000.0,
		"reset_game debe establecer enemy_vida a 10000")
	assert_false(Global.juego_terminado,
		"reset_game debe establecer juego_terminado a false")

func test_restar_vida_jugador_disminuye():
	Global.reset_game()
	var vida_inicial = Global.player_vida
	Global.restar_vida_jugador(2)
	assert_eq(Global.player_vida, vida_inicial - 2,
		"restar_vida_jugador debe disminuir la vida correctamente")

func test_restar_vida_jugador_muerte():
	Global.reset_game()
	Global.player_vida = 1
	Global.restar_vida_jugador(1)
	assert_true(Global.juego_terminado,
		"juego_terminado debe ser true cuando el jugador muere")

func test_restar_vida_jugador_no_al_terminar():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.player_vida
	Global.restar_vida_jugador(1)
	assert_eq(Global.player_vida, vida_antes,
		"restar_vida_jugador no debe afectar cuando el juego terminó")

func test_restar_vida_enemigo_disminuye():
	Global.reset_game()
	var vida_inicial = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_inicial - 100,
		"restar_vida_enemigo debe disminuir la vida correctamente")

func test_restar_vida_enemigo_varias_veces():
	Global.reset_game()
	Global.restar_vida_enemigo(100)
	Global.restar_vida_enemigo(200)
	Global.restar_vida_enemigo(300)
	assert_eq(Global.enemy_vida, 10000.0 - 600,
		"restar_vida_enemigo debe acumular las sustracciones")

func test_restar_vida_enemigo_muerte():
	Global.reset_game()
	Global.enemy_vida = 50
	Global.restar_vida_enemigo(50)
	assert_true(Global.juego_terminado,
		"juego_terminado debe ser true cuando el enemigo muere")

func test_restar_vida_enemigo_no_al_terminar():
	Global.reset_game()
	Global.juego_terminado = true
	var vida_antes = Global.enemy_vida
	Global.restar_vida_enemigo(100)
	assert_eq(Global.enemy_vida, vida_antes,
		"restar_vida_enemigo no debe afectar cuando el juego terminó")

func test_congelar_pantalla_estado():
	Global.juego_terminado = false
	Global.congelar_pantalla("test")
	assert_true(Global.juego_terminado,
		"congelar_pantalla debe establecer juego_terminado a true")
