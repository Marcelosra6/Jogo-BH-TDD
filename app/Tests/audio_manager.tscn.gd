@tool
extends GutTest


func pre_run():
	Global.reset_game()


func test_input_actions_existen():
	assert_has(InputMap.get_actions(), "left",
		"left debe estar definido en InputMap")
	assert_has(InputMap.get_actions(), "right",
		"right debe estar definido en InputMap")
	assert_has(InputMap.get_actions(), "up",
		"up debe estar definido en InputMap")
	assert_has(InputMap.get_actions(), "down",
		"down debe estar definido en InputMap")
	assert_has(InputMap.get_actions(), "fire",
		"fire debe estar definido en InputMap")


func test_tecla_A_bindeada_left():
	var events = InputMap.action_get_events("left")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_A:
			found = true
	assert_true(found, "Tecla A debe estar bindeada a left")


func test_flecha_izquierda_bindeada_left():
	var events = InputMap.action_get_events("left")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_LEFT:
			found = true
	assert_true(found, "Flecha izquierda debe estar bindeada a left")


func test_tecla_D_bindeada_right():
	var events = InputMap.action_get_events("right")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_D:
			found = true
	assert_true(found, "Tecla D debe estar bindeada a right")


func test_flecha_derecha_bindeada_right():
	var events = InputMap.action_get_events("right")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_RIGHT:
			found = true
	assert_true(found, "Flecha derecha debe estar bindeada a right")


func test_tecla_W_bindeada_up():
	var events = InputMap.action_get_events("up")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_W:
			found = true
	assert_true(found, "Tecla W debe estar bindeada a up")


func test_flecha_arriba_bindeada_up():
	var events = InputMap.action_get_events("up")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_UP:
			found = true
	assert_true(found, "Flecha arriba debe estar bindeada a up")


func test_tecla_S_bindeada_down():
	var events = InputMap.action_get_events("down")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_S:
			found = true
	assert_true(found, "Tecla S debe estar bindeada a down")


func test_flecha_abajo_bindeada_down():
	var events = InputMap.action_get_events("down")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_DOWN:
			found = true
	assert_true(found, "Flecha abajo debe estar bindeada a down")


func test_espacio_bindeado_fire():
	var events = InputMap.action_get_events("fire")
	var found = false
	for e in events:
		if e is InputEventKey and e.physical_keycode == KEY_SPACE:
			found = true
	assert_true(found, "Barra espaciadora debe estar bindeada a fire")


func test_movimiento_izquierda_con_tecla():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var x_anterior = jugador.global_position.x
	Input.action_press("left")
	jugador._process(0.016)
	Input.action_release("left")
	assert_lt(jugador.global_position.x, x_anterior,
		"jogador debe moverse a la izquierda con left")


func test_movimiento_derecha_con_tecla():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var x_anterior = jugador.global_position.x
	Input.action_press("right")
	jugador._process(0.016)
	Input.action_release("right")
	assert_gt(jugador.global_position.x, x_anterior,
		"jogador debe moverse a la derecha con right")


func test_movimiento_arriba_con_tecla():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var y_anterior = jugador.global_position.y
	Input.action_press("up")
	jugador._process(0.016)
	Input.action_release("up")
	assert_lt(jugador.global_position.y, y_anterior,
		"jogador debe moverse arriba con up")


func test_movimiento_abajo_con_tecla():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	add_child_autoqfree(jugador)
	jugador.global_position = Vector2(300, 300)
	var y_anterior = jugador.global_position.y
	Input.action_press("down")
	jugador._process(0.016)
	Input.action_release("down")
	assert_gt(jugador.global_position.y, y_anterior,
		"jogador debe moverse abajo con down")


func test_disparo_con_espacio():
	var jugador = load("res://Scenes/jogador.tscn").instantiate()
	var padre = Node2D.new()
	add_child_autoqfree(padre)
	padre.add_child(jugador)
	Input.action_press("fire")
	jugador._process(0.016)
	Input.action_release("fire")
	for i in range(padre.get_child_count()):
		var hijo = padre.get_child(i)
		if hijo.is_in_group("Bala"):
			assert_true(hijo is Area2D,
				"debe criar una bala al presionar espacio")
			return
	assert_eq(padre.get_child_count(), 2,
		"debe haber 2 hijos (jugador + 1 bala) al disparar con espacio")
