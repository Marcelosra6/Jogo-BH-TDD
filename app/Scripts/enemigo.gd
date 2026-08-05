extends Node2D

var cadencia: float = 0.4
var timer_disparo: float = 0.0

var vida = Global.enemy_vida
var muerto: bool = false

# Movimientos
var tiempo_movimiento: float = 0.0
var tiempo_infinito: float = 0.0
var centro_infinito_x: float = 0.0
var centro_infinito_y: float = 0.0
var limite_derecha: float = 0.0
var limite_izquierda: float = 0.0

# Banderas de control
var atacando: bool = false
var finInicial: bool = false

# Escenas
var escenaBala = load("res://Scenes/bala_enemigo.tscn")
var escenaBola = load("res://Scenes/bola_enemigo.tscn")
var escenaDisPejBal = load("res://Scenes/dis_pej_bal.tscn")
var escenaDisLejRay = load("res://Scenes/dis_lej_ray.tscn")

@onready var puntoDisparo = $Area2D/CollisionShape2D

func _ready() -> void:
	var ancho = get_viewport().get_visible_rect().size.x
	limite_derecha = ancho - 50.0 
	limite_izquierda = 50.0
	centro_infinito_x = ancho / 2.0
	centro_infinito_y = position.y
	#Fase inicial
	ejecutarInicial()

func _process(delta: float) -> void:
	if vida <= 0:
		return
	#si no esta terminada la inicial
	if not finInicial:
		tiempo_movimiento += delta
		var t = tiempo_movimiento * 1.5
		#Fase 1 movimiento circular
		var ancho = get_viewport().get_visible_rect().size.x
		var radio_circular = (ancho - 400) / 2.0
		position.x = centro_infinito_x + radio_circular * cos(t)
		position.y = centro_infinito_y + radio_circular * sin(t)
	else:	
		#Fase 2 de ataque
		tiempo_infinito += delta
		var t = tiempo_infinito * 1.5
		var radio_x = (limite_derecha - limite_izquierda) / 2.0
		var radio_y = radio_x * 0.35
		position.x = centro_infinito_x + radio_x * sin(t)
		position.y = centro_infinito_y + radio_y * sin(2.0 * t)
		
		# Control de disparo en movimiento
		if not atacando:
			timer_disparo -= delta
			if timer_disparo <= 0:
				timer_disparo = cadencia
				patronMovimiento()
				
func recibir_dano(cantidad: float) -> void:
	if muerto: return
	Global.restar_vida_enemigo(cantidad)
	vida = Global.enemy_vida
	if vida <= 0:
		morir()
		
func morir() -> void:
	muerto = true
	AudioManager.play_muerte()
	set_process(false)
#Fases y Patrones
func ejecutarInicial() -> void:
	atacando = true
	#disparo estatico
	await disparoEstatico()
	#patrones diferentes
	finInicial = true
	atacando = false

func patronMovimiento() -> void:
	atacando = true
	await disparoRafaga()
	if randi_range(1, 100) <= 67:
		disparo180()	
	if randi_range(1, 100) <= 40:
		await disparoBola()
	atacando = false

#Disparos
func disparoEstatico() -> void:
	var ctdRafagas = randi_range(20, 30)
	for raf in ctdRafagas:
		if muerto: return
		for bal in 26:
			var ang = (360.0 / 26.0) * bal
			var b = escenaBala.instantiate()
			b.velocidad = 150.0
			b.global_position = puntoDisparo.global_position
			b.direccion = Vector2.DOWN.rotated(deg_to_rad(ang))
			get_parent().add_child.call_deferred(b)
		AudioManager.play_bala_enemigo2()
		await get_tree().create_timer(0.6).timeout

func disparoRafaga() -> void:
	var ctdBalas = randi_range(20, 30)
	var arco_total = 90.0
	
	for balas in ctdBalas:
		if muerto: return
		var angulo_offset = ((arco_total / (ctdBalas - 1)) * balas) - (arco_total / 2.0)	
		var b = escenaBala.instantiate()
		b.global_position = puntoDisparo.global_position
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(angulo_offset))
		get_parent().add_child(b)
		
		AudioManager.play_bala_enemigo()
		await get_tree().create_timer(0.20).timeout

func disparo180() -> void:
	for i in 12:
		if muerto: return
		var ang = (360.0 / 12.0) * i
		var b = escenaBala.instantiate()
		b.global_position = puntoDisparo.global_position
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(ang))
		get_parent().add_child(b)
		
	AudioManager.play_bala_enemigo2()

func disparoBola() -> void:
	for i in 3:
		if muerto: return
		var b = escenaBola.instantiate()
		b.global_position = puntoDisparo.global_position
		get_parent().add_child(b)
		
		AudioManager.play_bola_enemigo()
		await get_tree().create_timer(0.5).timeout
