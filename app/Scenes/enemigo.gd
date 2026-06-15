extends Node2D

var velocidad: float = 300.0
var limite_derecha: float = 0.0
var limite_izquierda: float = 0.0
var limite_sur: float = 0.0
var avanzando: bool = true
var cadencia: float = 0.20
var timer_disparo: float = 0.0
var escenaBala = load("res://bala_enemigo.tscn")

var ctdBalas: float = 0.0
var angulo_actual: float = 0.0
var disparando: bool = false
var timer_entre_balas: float = 0.0

var vida = Global.enemy_vida
func _ready() -> void:
	var ancho = get_viewport().get_visible_rect().size.x
	limite_derecha = ancho - 50 
	limite_izquierda = 50

func _process(delta):
	if avanzando:
		position.x += velocidad * delta
		if position.x >= limite_derecha:
			avanzando = false
	else:
		position.x -= velocidad * delta
		if position.x <= limite_izquierda:
			avanzando = true
	
	if disparando:
		if timer_entre_balas > 0:
			timer_entre_balas -= delta
		else:
			disparar_siguiente_bala()
	else:
		if timer_disparo > 0:
			timer_disparo -= delta
		else:
			timer_disparo = cadencia
			disparo1()
			if randi()%100 + 1 < 60:
				position.y += 360
				disparo2()

func disparo1() -> void:
	ctdBalas = randf_range(20.0, 30.0)
	angulo_actual = 0
	disparando = true
	timer_entre_balas = 0.0
func disparo2() -> void:
	for i in 60:
		var ang = (360/12)*i
		var b = escenaBala.instantiate()
		b.global_position = $Area2D/CollisionShape2D.global_position
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(ang))
		get_parent().add_child(b)
	
func disparar_siguiente_bala() -> void:
	var arco_total = 90.0
	var angulo_offset = ((arco_total / (ctdBalas - 1)) * angulo_actual) - (arco_total / 2.0)
	var b = escenaBala.instantiate()
	b.global_position = $Area2D/CollisionShape2D.global_position #dispara desde la boca
	b.direccion = Vector2.DOWN.rotated(deg_to_rad(angulo_offset))
	get_parent().add_child(b)
	angulo_actual += 1
	timer_entre_balas = 0.16#delay
	if angulo_actual >= ctdBalas:
		disparando = false
