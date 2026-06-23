extends Node2D

var escenaBala = load("res://bala.tscn")
var cadencia = 0.1
var timer_disparo = 0.0
var velocidad_jugador: float = 500.0 
var modo_teclado: bool = false

func _process(delta):
	var move_vec = Vector2.ZERO
	if Input.is_action_pressed("right"):
		move_vec.x += 1
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
	if Input.is_action_pressed("down"):
		move_vec.y += 1
	if Input.is_action_pressed("up"):
		move_vec.y -= 1

	if move_vec != Vector2.ZERO:
		modo_teclado = true
		position += move_vec.normalized() * velocidad_jugador * delta
	elif not modo_teclado:
		global_position = get_global_mouse_position()

	if Input.is_action_just_pressed("click"):
		modo_teclado = false

	if timer_disparo > 0:
		timer_disparo -= delta
	if (Input.is_action_pressed("click") or Input.is_action_pressed("fire")) and timer_disparo <= 0:
		timer_disparo = cadencia
		disparar()

func disparar() -> void:
	var b = escenaBala.instantiate()
	b.global_position = global_position
	get_parent().add_child(b)
	AudioManager.play_bala()
