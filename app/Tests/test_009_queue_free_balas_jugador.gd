extends GutTest


var escenaBala = preload("res://bala.tscn")


func pre_run():
	Global.reset_game()


func test_bala_jogador_queue_free_acima_limite(p = use_parameters([
	[-51], [-60], [-100], [-999]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_queued_for_deletion(bala,
		"bala deve ser eliminada quando y < -50 (y=%s)" % p[0])


func test_bala_jogador_permanece_abaixo_limite(p = use_parameters([
	[-49], [-30], [0], [100], [500]
])):
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = p[0]
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"bala nao deve ser eliminada quando y >= -50 (y=%s)" % p[0])


func test_bala_jogador_morre_exatamente_no_limite_apos_movimento():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.position.y = -49.0
	bala._process(0.1)
	assert_queued_for_deletion(bala,
		"bala em y=-49 deve ser eliminada apos mover com delta 0.1")
