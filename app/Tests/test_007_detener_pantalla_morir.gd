@tool
extends GutTest

var escenaBala = preload("res://bala.tscn")

func pre_run():
	Global.reset_game()

func test_bala_jugador_queue_free_sobre_limite(p = use_parameters([
	[-51], [-60], [-100], [-999]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_true(bala.is_queued_for_deletion(),
		"La bala debe eliminarse cuando y < -50 (y=%s)" % p[0])

func test_bala_jugador_permanece_bajo_limite(p = use_parameters([
	[-49], [-30], [0], [100], [500]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"La bala no debe eliminarse cuando y >= -50 (y=%s)" % p[0])

func test_bala_jugador_muere_exactamente_en_limite_tras_movimiento():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = -49.0
	bala._process(0.1)
	assert_true(bala.is_queued_for_deletion(),
		"La bala en y=-49 debe eliminarse tras moverse con delta 0.1")
