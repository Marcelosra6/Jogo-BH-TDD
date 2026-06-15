extends GutTest


func pre_run():
	Global.reset_game()


func test_bala_enemigo_quita_un_punto_de_vida():
	var bala = load("res://bala_enemigo.tscn").instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.player_vida
	var area_jogador = Area2D.new()
	var nodo_jogador = Node2D.new()
	nodo_jogador.name = "Jogador"
	nodo_jogador.add_child(area_jogador)
	add_child_autoqfree(nodo_jogador)
	bala._on_area_2d_area_entered(area_jogador)
	assert_eq(Global.player_vida, vida_antes - 1,
		"deve restar 1 de vida do jogador")


func test_bala_enemigo_queue_free_ao_acertar():
	var bala = load("res://bala_enemigo.tscn").instantiate()
	add_child_autoqfree(bala)
	var area_jogador = Area2D.new()
	var nodo_jogador = Node2D.new()
	nodo_jogador.name = "Jogador"
	nodo_jogador.add_child(area_jogador)
	add_child_autoqfree(nodo_jogador)
	bala._on_area_2d_area_entered(area_jogador)
	assert_queued_for_deletion(bala, "bala deve ser eliminada ao acertar o jogador")


func test_bala_enemigo_nao_afeta_outros_objetos():
	var bala = load("res://bala_enemigo.tscn").instantiate()
	add_child_autoqfree(bala)
	var vida_antes = Global.player_vida
	var area_outro = Area2D.new()
	var nodo_outro = Node2D.new()
	nodo_outro.name = "Outro"
	nodo_outro.add_child(area_outro)
	add_child_autoqfree(nodo_outro)
	bala._on_area_2d_area_entered(area_outro)
	assert_eq(Global.player_vida, vida_antes,
		"nao deve alterar vida se nao for o jogador")
