extends GutTest


var escenaJogador = preload("res://Scenes/jogador.tscn")
var escenaBala = preload("res://bala.tscn")


func pre_run():
	Global.reset_game()


func test_disparar_instancia_bala_no_pai():
	var jugador = escenaJogador.instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(jugador)
	var contagem_antes = pai.get_child_count()
	jugador.disparar()
	assert_eq(pai.get_child_count(), contagem_antes + 1,
		"deve criar 1 bala no pai ao disparar")


func test_bala_posicao_igual_jogador_ao_disparar():
	var jugador = escenaJogador.instantiate()
	var pai = Node2D.new()
	add_child_autoqfree(pai)
	pai.add_child(jugador)
	jugador.global_position = Vector2(150, 300)
	jugador.disparar()
	var bala = pai.get_child(pai.get_child_count() - 1)
	assert_eq(bala.global_position, Vector2(150, 300),
		"bala deve nascer na posicao global do jogador")


func test_bala_movimento_subindo():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	bala._process(0.016)
	assert_lt(bala.global_position.y, 500,
		"bala deve mover para cima (y diminuindo)")


func test_bala_subindo_cada_frame():
	var bala = escenaBala.instantiate()
	add_child_autoqfree(bala)
	bala.global_position = Vector2(100, 500)
	var y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"bala deve subir a cada frame")
	y_anterior = bala.global_position.y
	bala._process(0.016)
	assert_lt(bala.global_position.y, y_anterior,
		"bala deve continuar subindo no segundo frame")
