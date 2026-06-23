@tool
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
	assert_true(bala.is_queued_for_deletion(),
		"bala acima de la pantalla se elimina")

func test_bala_enemigo_queue_free_debajo_pantalla():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_tree().root.get_visible_rect()
	bala.direccion = Vector2.DOWN
	bala.position.y = vp.size.y + 100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"La bala debajo de la pantalla debe eliminarse")

func test_bala_enemigo_queue_free_derecha_pantalla():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_tree().root.get_visible_rect()
	bala.direccion = Vector2.RIGHT
	bala.position.x = vp.size.x + 100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"La bala a la derecha de la pantalla debe eliminarse")

func test_bala_enemigo_queue_free_izquierda_pantalla():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.LEFT
	bala.position.x = -100
	bala._process(0.016)
	assert_true(bala.is_queued_for_deletion(),
		"La bala a la izquierda de la pantalla debe eliminarse")

func test_bala_enemigo_permanece_en_centro_pantalla():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_tree().root.get_visible_rect()
	bala.direccion = Vector2.DOWN
	bala.position = vp.size / 2
	bala._process(0.016)
	assert_false(bala.is_queued_for_deletion(),
		"La bala en el centro de la pantalla no debe eliminarse")

func test_bala_enemigo_permanece_en_limite_inferior():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	var vp = get_tree().root.get_visible_rect()
	bala.direccion = Vector2.DOWN
	bala.position.y = vp.size.y
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"La bala exactamente en el límite inferior debe permanecer (sin margen)")

func test_bala_enemigo_limite_superior_negativo_50():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.direccion = Vector2.ZERO
	bala.position.y = -50
	bala._process(0.001)
	assert_false(bala.is_queued_for_deletion(),
		"La bala en y=-50 debe permanecer (el límite es y < -50)")
