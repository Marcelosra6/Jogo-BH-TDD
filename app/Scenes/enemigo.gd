extends Node2D

var velocidad: float = 300.0
var limite_derecha: float = 0.0
var limite_izquierda: float = 0.0
var limite_sur: float = 0.0
var avanzando: bool = true
var cadencia: float = 0.20
var timer_disparo: float = 0.0
var escenaBala = load("res://bala_enemigo.tscn")
var escenaBola = load("res://bola_enemigo.tscn")
var ctdBalas: float = 0.0
var angulo_actual: float = 0.0
var disparando: bool = false
var timer_entre_balas: float = 0.0

var vida = Global.enemy_vida
var tiempo_infinito: float = 0.0
var centro_infinito_x: float = 0.0
var centro_infinito_y: float = 0.0
var disparos_bola_restantes: int = 3
var disparando_bola: bool = false
var bolas_en_secuencia: int = 0
var timer_entre_bolas: float = 0.0

func _ready() -> void:
	var ancho = get_viewport().get_visible_rect().size.x
	limite_derecha = ancho - 50 
	limite_izquierda = 50
	centro_infinito_x = get_viewport_rect().size.x / 2.0
	centro_infinito_y = position.y

func _process(delta):
	tiempo_infinito += delta
	var t = tiempo_infinito * 1.5
	var radio_x = (limite_derecha - limite_izquierda) / 2.0
	var radio_y = radio_x * 0.35
	position.x = centro_infinito_x + radio_x * sin(t)
	position.y = centro_infinito_y + radio_y * sin(2.0 * t)
	
	if disparando_bola:
		if timer_entre_bolas > 0:
			timer_entre_bolas -= delta
		else:
			disparar_siguiente_bola()
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
			
			if randi()%100 + 1 < 67:
				disparo2()
				
			if randi()%100 + 1 < 40:
				disparo3()

func disparo1() -> void:
	ctdBalas = randf_range(20.0, 30.0)
	angulo_actual = 0
	disparando = true
	timer_entre_balas = 0.0
	AudioManager.play_bala_enemigo()

func disparo2() -> void:
	for i in 60:
		var ang = (360/12)*i
		var b = escenaBala.instantiate()
		b.global_position = $Area2D/CollisionShape2D.global_position
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(ang))
		get_parent().add_child(b)
	AudioManager.play_bala_enemigo()
func disparo3() -> void:
	if disparos_bola_restantes <= 0 or disparando_bola:
		return
	disparos_bola_restantes -= 1
	bolas_en_secuencia = 3
	disparando_bola = true
	timer_entre_bolas = 0.0
func disparar_siguiente_bola() -> void:
	var b = escenaBola.instantiate()
	b.global_position = $Area2D/CollisionShape2D.global_position
	get_parent().add_child(b)
	bolas_en_secuencia -= 1
	timer_entre_bolas = 0.5
	AudioManager.play_bola_enemigo()
	if bolas_en_secuencia <= 0:
		disparando_bola = false
		
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
