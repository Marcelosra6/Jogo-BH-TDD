@tool
extends GutTest

func pre_run():
	Global.reset_game()


func test_bola_dania_jugador_al_colisionar():
	var bola = load("res://bola_enemigo.tscn").instantiate()
	add_child_autoqfree(bola)
	var vida_antes = Global.player_vida
	var area_jugador = Area2D.new()
	var nodo_jugador = Node2D.new()
	nodo_jugador.name = "Jogador"
	nodo_jugador.add_child(area_jugador)
	add_child_autoqfree(nodo_jugador)
	bola._on_area_2d_area_entered(area_jugador)
	assert_eq(Global.player_vida, vida_antes - 1,
		"bola debe restar 1 de vida al jugador")
		
func test_bola_tiene_direccion_y_mueve_abajo():
	var bola = load("res://bola_enemigo.tscn").instantiate()
	add_child_autoqfree(bola)
	bola.direccion = Vector2.DOWN
	bola.global_position = Vector2(100, 100)
	bola._process(0.5)
	assert_gt(bola.global_position.y, 100,
		"bola debe moverse hacia abajo con direccion DOWN")
	bola.direccion = Vector2.RIGHT
	var x_anterior = bola.global_position.x
	bola._process(0.5)
	assert_gt(bola.global_position.x, x_anterior,
		"bola debe moverse hacia la derecha con direccion RIGHT")

func test_bola_se_elimina_fuera_pantalla():
	var bola = load("res://bola_enemigo.tscn").instantiate()
	add_child_autoqfree(bola)
	bola.position = Vector2(-100, -100)
	bola._process(0.016)
	assert_true(bola.is_queued_for_deletion(),
		"La bola debe eliminarse al salir de la pantalla")
