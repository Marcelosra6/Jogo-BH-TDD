@tool
extends GutTest

const DisLejRay = preload("res://Scripts/dis_lej_ray.gd")

func pre_run():
	Global.reset_game()

func _crear_en_escena() -> Node:
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	var e = load("res://Scenes/dis_lej_ray.tscn").instantiate()
	padre.add_child(e)
	return e

func test_dis_lej_ray_forma_pentagono_invertido():
	var e = _crear_en_escena()
	assert_eq(e.vertices.size(), 5,
		"dis_lej_ray debe tener 5 vertices (pentagono)")
	var posiciones: Array = []
	for v in e.vertices:
		posiciones.append(v.position)
	var unicas = 0
	for p in posiciones:
		var repetida = false
		for q in posiciones:
			if p != q and p.distance_to(q) < 0.01:
				repetida = true
		if not repetida:
			unicas += 1
	assert_eq(unicas, 5,
		"Cada vertice del pentagono debe estar en una posicion distinta")

func test_dis_lej_ray_vertices_en_circulo_radio():
	var e = _crear_en_escena()
	for v in e.vertices:
		var dist = v.position.length()
		assert_almost_eq(dist, e.radio, 1.0,
			"Cada vertice debe estar a la distancia del radio")

func test_dis_lej_ray_dispara_lazeres_desde_cada_vertice():
	var e = _crear_en_escena()
	var cantidad_antes = e.get_parent().get_child_count()
	e.disparar_lazeres()
	assert_eq(e.get_parent().get_child_count(), cantidad_antes + 5,
		"disparar_lazeres debe crear un lazer por cada vertice")

func test_dis_lej_ray_lazer_es_estatico_y_muere_a_los_2s():
	var lazer = load("res://Scenes/lazer.tscn").instantiate()
	add_child_autoqfree(lazer)
	lazer._ready()
	assert_eq(lazer.tiempo_vida, 2.0,
		"el lazer debe durar 2 segundos")
	var timer = lazer.find_child("Timer", true, false)
	assert_not_null(timer,
		"el lazer debe crear un Timer para controlar su vida")
	assert_almost_eq(timer.wait_time, 2.0, 0.01,
		"el Timer del lazer debe ser de 2 segundos")

func test_dis_lej_ray_cooldown_5s():
	assert_almost_eq(DisLejRay.new().cooldown, 5.0, 0.01,
		"el cooldown de disparo debe ser de 5 segundos")

func test_dis_lej_ray_recibir_dano_mata():
	var e = _crear_en_escena()
	e.recibir_dano(999.0)
	assert_true(e.is_queued_for_deletion(),
		"dis_lej_ray debe eliminarse al recibir dano suficiente")
