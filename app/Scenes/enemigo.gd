extends Node2D
#movimiento no en infinito
var velocidad: float = 300.0
var limite_derecha: float = 0.0
var limite_izquierda: float = 0.0
var limite_sur: float = 0.0
var avanzando: bool = true

var cadencia: float = 0.4
var timer_disparo: float = 0.0
#escenas a usar
var escenaBala = load("res://bala_enemigo.tscn")
var escenaBola = load("res://bola_enemigo.tscn")
var escenaJugador = load("res://jogador.tscn")
@onready var puntoDisparo = $Area2D/CollisionShape2D
#vida
var vida = Global.enemy_vida
#movimiento en infinito
var tiempo_infinito: float = 0.0
var centro_infinito_x: float = 0.0
var centro_infinito_y: float = 0.0
#variables para disparos
@onready var timerEstatico = $Timer

func _ready() -> void:
	#definicion de limites 
	var ancho = get_viewport().get_visible_rect().size.x
	limite_derecha = ancho - 50 
	limite_izquierda = 50
	centro_infinito_x = get_viewport_rect().size.x / 2.0
	centro_infinito_y = position.y

func _process(delta):
	#primera parte, disparo estatico
	disparoEstatico()
	while vida > 0:
		if escenaJugador.position.y - position.y < 350.00 || vida == vida - 500:
			disparoEstatico()
		else:
			disparoRafaga()
			if randi()%100 + 1 < 67:
				disparo180()
				
			if randi()%100 + 1 < 40:
				disparoBola()
	#control de movimiento infinito
	tiempo_infinito += delta
	var t = tiempo_infinito * 1.5
	var radio_x = (limite_derecha - limite_izquierda) / 2.0
	var radio_y = radio_x * 0.35
	position.x = centro_infinito_x + radio_x * sin(t)
	position.y = centro_infinito_y + radio_y * sin(2.0 * t)
	#control de disparos
				
func disparoEstatico()-> void:
	var ctdRafagas = 10
	var ctdBalasxRafaga
	for i in ctdRafagas:
		var ang = (360.0*ctdRafagas)
	
func disparoRafaga() -> void:
	var ctdBalas= randf_range(20.0, 30.0)
	var anguloActual: int = 0
	var timerBalas: float= 0.0
	for i in ctdBalas:
		var arco_total = 90.0
		var angulo_offset = ((arco_total / (ctdBalas - 1)) * i) - (arco_total / 2.0)	
		var b = escenaBala.instantiate()
		b.global_position = puntoDisparo.global_position #dispara desde la boca
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(angulo_offset))
		get_parent().add_child(b)
		anguloActual += 1
		timerBalas = 0.16#delay
		AudioManager.play_bala_enemigo()
		await get_tree().create_timer(0.16).timeout
		
func disparo180() -> void:
	for i in 12:
		var ang = (360.0/12.0)*i
		var b = escenaBala.instantiate()
		b.global_position = puntoDisparo.global_position
		b.direccion = Vector2.DOWN.rotated(deg_to_rad(ang))
		get_parent().add_child(b)
	AudioManager.play_bala_enemigo2()
func disparoBola() -> void:
	var bolasRestantes: int = -1
	for i in 3:
		var b = escenaBola.instantiate()
		b.global_position = puntoDisparo.global_position
		get_parent().add_child(b)
		
		AudioManager.play_bola_enemigo()
		await get_tree().create_timer(0.5).timeout
