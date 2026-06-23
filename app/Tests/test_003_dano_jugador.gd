@tool
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
		"debe restar una vida al jugador")


func test_bala_enemigo_queue_free_al_acertar():
	var bala = load("res://bala_enemigo.tscn").instantiate()
	add_child_autoqfree(bala)
	var area_jugador = Area2D.new()
	var nodo_jugador = Node2D.new()
	nodo_jugador.name = "Jogador"
	nodo_jugador.add_child(area_jugador)
	add_child_autoqfree(nodo_jugador)
	bala._on_area_2d_area_entered(area_jugador)
	assert_true(bala.is_queued_for_deletion(),
		"La bala debe ser eliminada al acertar al jugador")
