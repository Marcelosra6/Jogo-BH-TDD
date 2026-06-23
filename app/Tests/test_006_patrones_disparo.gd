@tool
extends GutTest

const BalaEnemigo = preload("res://bala_enemigo.gd") 

func pre_run():
	Global.reset_game()

func test_disparo2_crea_sesenta_balas():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	var cantidad_antes = padre.get_child_count()
	enemigo.disparo2()
	assert_eq(padre.get_child_count(), cantidad_antes + 60,
		"disparo2 debe crear 60 balas en el padre")

func test_disparo2_balas_tienen_direccion():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	enemigo.disparo2()
	
	var balas_validadas = 0
	for i in range(padre.get_child_count()):
		var hijo = padre.get_child(i)
		if hijo is BalaEnemigo:
			assert_true("direccion" in hijo, "Cada bala debe tener la variable direccion")
			balas_validadas += 1
			
	assert_eq(balas_validadas, 60, "Se debieron validar exactamente 60 balas")

func test_disparo1_inicia_estado_secuencial():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	add_child_autoqfree(enemigo)
	enemigo._ready()
	enemigo.disparo1()
	assert_true(enemigo.disparando,
		"disparo1 debe activar el estado de disparo secuencial")
	assert_gt(enemigo.ctdBalas, 0,
		"disparo1 debe definir ctdBalas > 0")

func test_disparo1_ctdBalas_entre_20_y_30():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	add_child_autoqfree(enemigo)
	enemigo._ready()
	for _j in 20:
		enemigo.disparo1()
		assert_between(enemigo.ctdBalas, 20.0, 30.0,
			"ctdBalas debe estar entre 20 y 30")

func test_disparar_siguiente_bala_crea_una_bala():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	enemigo.disparo1()
	var cantidad_antes = padre.get_child_count()
	enemigo.disparar_siguiente_bala()
	assert_eq(padre.get_child_count(), cantidad_antes + 1,
		"disparar_siguiente_bala debe crear 1 bala")

func test_disparar_siguiente_bala_tiene_direccion():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	enemigo.disparo1()
	enemigo.disparar_siguiente_bala()
	
	var balas_validadas = 0
	for i in range(padre.get_child_count()):
		var hijo = padre.get_child(i)
		if hijo is BalaEnemigo:
			assert_ne(hijo.direccion, Vector2.ZERO, "La bala debe tener direccion distinta de cero")
			balas_validadas += 1
			
	assert_eq(balas_validadas, 1, "Se debió validar exactamente 1 bala")

func test_disparo2_finaliza_en_el_mismo_frame():
	var enemigo = load("res://Scenes/enemigo.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(enemigo)
	enemigo._ready()
	enemigo.disparo2()
	assert_false(enemigo.disparando,
		"disparo2 no debe activar el estado disparando (es instantáneo)")
