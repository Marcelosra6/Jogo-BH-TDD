@tool
extends GutTest

const DisPejBal = preload("res://Scenes/dis_pej_bal.gd")
const BalaEnemigo = preload("res://bala_enemigo.gd")

func pre_run():
	Global.reset_game()

func _crear_en_escena() -> Node:
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	var e = load("res://Scenes/dis_pej_bal.tscn").instantiate()
	padre.add_child(e)
	e._ready()
	return e

func test_dis_pej_bal_movimiento_zigzag_horizontal():
	var e = _crear_en_escena()
	e.dir_x = 1
	var x_antes = e.position.x
	e._process(0.5)
	assert_gt(e.position.x, x_antes,
		"dis_pej_bal debe moverse horizontalmente en zigzag")

func test_dis_pej_bal_baja_y_se_detiene_en_mitad():
	var e = _crear_en_escena()
	e._process(10.0)
	assert_true(e.detenido,
		"dis_pej_bal debe detenerse al llegar a su limite de bajada")
	var alto = get_viewport().get_visible_rect().size.y
	assert_gt(e.limite_y, alto * 0.5,
		"dis_pej_bal debe bajar mas de la mitad de la pantalla")
	assert_lt(e.limite_y, alto - 1.0,
		"dis_pej_bal no debe llegar al borde inferior")

func test_dis_pej_bal_dispara_bala_enemigo():
	var e = _crear_en_escena()
	var cantidad_antes = e.get_parent().get_child_count()
	e.disparar()
	assert_eq(e.get_parent().get_child_count(), cantidad_antes + 1,
		"dis_pej_bal debe disparar bala_enemigo.tscn")

func test_dis_pej_bal_espawnear_crea_entre_3_y_6():
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	DisPejBal.espawnear(padre)
	var ctd = 0
	for i in range(padre.get_child_count()):
		if padre.get_child(i) is DisPejBal:
			ctd += 1
	assert_between(float(ctd), 3.0, 6.0,
		"espawnear debe crear entre 3 y 6 dis_pej_bal")

func test_dis_pej_bal_espawnear_desde_arriba():
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	DisPejBal.espawnear(padre)
	for i in range(padre.get_child_count()):
		var hijo = padre.get_child(i)
		if hijo is DisPejBal:
			assert_lt(hijo.position.y, 0.0,
				"dis_pej_bal debe spawnear desde arriba (y < 0)")

func test_dis_pej_bal_recibir_dano_mata():
	var e = _crear_en_escena()
	e.recibir_dano(999.0)
	assert_true(e.is_queued_for_deletion(),
		"dis_pej_bal debe eliminarse al recibir dano suficiente")
