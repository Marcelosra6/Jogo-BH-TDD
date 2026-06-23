@tool
extends GutTest

var escenaBala = preload("res://bala_enemigo.tscn")

func pre_run():
	Global.reset_game()

func test_bala_enemigo_dania_jugador():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.player_vida
	var area_jugador = Area2D.new()
	var nodo_jugador = Node2D.new()
	nodo_jugador.name = "Jogador"
	nodo_jugador.add_child(area_jugador)
	add_child_autoqfree(nodo_jugador)
	bala._on_area_2d_area_entered(area_jugador)
	assert_eq(Global.player_vida, vida_antes - 1,
		"bala enemigo debe restar 1 de vida al jugador")


func test_bala_enemigo_movimiento():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.DOWN
	bala.global_position = Vector2(100, 100)
	bala._process(0.016)
	assert_gt(bala.global_position.y, 100,
		"bala enemigo debe moverse hacia abajo con direccion DOWN")

func test_bala_enemigo_queue_free_acima():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.UP
	bala.position.y = -100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"bala arriba de la pantalla se elimina")

func test_bala_enemigo_queue_free_debajo():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport().get_visible_rect()
	bala.direccion = Vector2.DOWN
	bala.position.y = vp.size.y + 100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"bala debajo de la pantalla se elimina")

func test_bala_enemigo_queue_free_derecha():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport().get_visible_rect()
	bala.direccion = Vector2.RIGHT
	bala.position.x = vp.size.x + 100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"bala a la derecha de la pantalla se elimina")

func test_bala_enemigo_queue_free_izquierda():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.LEFT
	bala.position.x = -100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"bala a la izquierda de la pantalla se elimina")

func test_bala_enemigo_permanece_en_centro():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport().get_visible_rect()
	bala.direccion = Vector2.DOWN
	bala.position = vp.size / 2
	bala._process(0.016)
	assert_false(bala.is_queued_for_deletion(),
		"bala en el centro no debe eliminarse")

func test_bala_enemigo_queue_free_al_acertar():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var area_jugador = Area2D.new()
	var nodo_jugador = Node2D.new()
	nodo_jugador.name = "Jogador"
	nodo_jugador.add_child(area_jugador)
	add_child_autoqfree(nodo_jugador)
	bala._on_area_2d_area_entered(area_jugador)
	assert_true(bala.is_queued_for_deletion(),
		"bala enemigo debe eliminarse al acertar al jugador")
