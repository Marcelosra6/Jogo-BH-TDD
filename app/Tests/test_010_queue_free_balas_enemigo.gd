extends GutTest


var escenaBala = preload("res://bala_enemigo.tscn")


func pre_run():
	Global.reset_game()


func test_bala_enemigo_queue_free_acima_tela():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.UP
	bala.position.y = -100
	bala._process(0.016)
	assert_queued_for_deletion(bala,
		"bala acima da tela deve ser eliminada")


func test_bala_enemigo_queue_free_abaixo_tela():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport_rect()
	bala.direccion = Vector2.DOWN
	bala.position.y = vp.size.y + 100
	bala._process(0.016)
	assert_queued_for_deletion(bala,
		"bala abaixo da tela deve ser eliminada")


func test_bala_enemigo_queue_free_direita_tela():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport_rect()
	bala.direccion = Vector2.RIGHT
	bala.position.x = vp.size.x + 100
	bala._process(0.016)
	assert_queued_for_deletion(bala,
		"bala a direita da tela deve ser eliminada")


func test_bala_enemigo_queue_free_esquerda_tela():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.LEFT
	bala.position.x = -100
	bala._process(0.016)
	assert_queued_for_deletion(bala,
		"bala a esquerda da tela deve ser eliminada")


func test_bala_enemigo_permanece_no_centro_tela():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport_rect()
	bala.direccion = Vector2.DOWN
	bala.position = vp.size / 2
	bala._process(0.016)
	assert_false(bala.is_queued_for_deletion(),
		"bala no centro da tela nao deve ser eliminada")


func test_bala_enemigo_permanece_no_limite_inferior():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_viewport_rect()
	bala.direccion = Vector2.DOWN
	bala.position.y = vp.size.y
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"bala exatamente no limite inferior deve permanecer (sem margem)")


func test_bala_enemigo_limite_superior_negativo_50():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.UP
	bala.position.y = -50
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"bala em y=-50 deve permanecer (limite e y < -50)")
