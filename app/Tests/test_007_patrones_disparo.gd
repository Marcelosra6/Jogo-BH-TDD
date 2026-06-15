extends GutTest


func pre_run():
	Global.reset_game()


func test_disparo2_crea_sesenta_balas():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(inimigo)
	inimigo._ready()
	var contagem_antes = pai.get_child_count()
	inimigo.disparo2()
	assert_eq(pai.get_child_count(), contagem_antes + 60,
		"disparo2 deve criar 60 balas no pai")


func test_disparo2_balas_tem_direccion():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(inimigo)
	inimigo._ready()
	inimigo.disparo2()
	for i in range(pai.get_child_count()):
		var filho = pai.get_child(i)
		if filho.has_method("_process"):
			assert_has(filho, "direccion",
				"cada bala deve ter variavel direccion")


func test_disparo1_inicia_estado_secuencial():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	add_child_autoqfree(inimigo)
	inimigo._ready()
	inimigo.disparo1()
	assert_true(inimigo.disparando,
		"disparo1 deve ativar estado de disparo secuencial")
	assert_gt(inimigo.ctdBalas, 0,
		"disparo1 deve definir ctdBalas > 0")


func test_disparo1_ctdBalas_entre_20_y_30():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	add_child_autoqfree(inimigo)
	inimigo._ready()
	for _j in 20:
		inimigo.disparo1()
		assert_between(inimigo.ctdBalas, 20.0, 30.0,
			"ctdBalas deve estar entre 20 e 30")


func test_disparar_siguiente_bala_crea_una_bala():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(inimigo)
	inimigo._ready()
	inimigo.disparo1()
	var contagem_antes = pai.get_child_count()
	inimigo.disparar_siguiente_bala()
	assert_eq(pai.get_child_count(), contagem_antes + 1,
		"disparar_siguiente_bala deve criar 1 bala")


func test_disparar_siguiente_bala_bala_tem_direccion():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(inimigo)
	inimigo._ready()
	inimigo.disparo1()
	inimigo.disparar_siguiente_bala()
	for i in range(pai.get_child_count()):
		var filho = pai.get_child(i)
		if filho.has_method("_process"):
			assert_not_equal(filho.direccion, Vector2.ZERO,
				"bala deve ter direccion diferente de zero")


func test_disparo2_finaliza_no_mesmo_frame():
	var inimigo = load("res://Scenes/enemigo.tscn").instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(inimigo)
	inimigo._ready()
	inimigo.disparo2()
	assert_false(inimigo.disparando,
		"disparo2 nao deve ativar estado disparando (e instantaneo)")
