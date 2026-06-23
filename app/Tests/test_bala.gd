@tool
extends GutTest

var escenaBala = preload("res://bala.tscn")

func pre_run():
	Global.reset_game()

func test_bala_dania_enemigo_al_colisionar():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.enemy_vida
	var area_enemigo = Area2D.new()
	var nodo_enemigo = Node2D.new()
	nodo_enemigo.name = "Enemigo"
	nodo_enemigo.add_child(area_enemigo)
	add_child_autoqfree(nodo_enemigo)
	bala._on_area_2d_area_entered(area_enemigo)
	assert_eq(Global.enemy_vida, vida_antes - 100,
		"bala debe restar 100 de vida al enemigo")
		
func test_bala_movimiento_hacia_arriba():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	bala._process(0.016)
	assert_lt(bala.global_position.y, 500,
		"La bala debe moverse hacia arriba (y disminuyendo)")

func test_bala_sube_cada_frame():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	var y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"La bala debe subir en cada frame")
	y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"La bala debe continuar subiendo en el segundo frame")

func test_bala_queue_free_sobre_limite(p = use_parameters([
	[-51], [-60], [-100], [-999]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_true(bala.is_queued_for_deletion(),
		"La bala debe eliminarse cuando y < -50 (y=%s)" % p[0])

func test_bala_permanece_bajo_limite(p = use_parameters([
	[-49], [-30], [0], [100], [500]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"La bala no debe eliminarse cuando y >= -50 (y=%s)" % p[0])

func test_bala_muere_exactamente_en_limite_tras_movimiento():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = -49.0
	bala._process(0.1)
	assert_true(bala.is_queued_for_deletion(),
		"La bala en y=-49 debe eliminarse tras moverse con delta 0.1")
