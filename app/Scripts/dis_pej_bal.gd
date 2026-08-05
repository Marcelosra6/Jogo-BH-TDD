extends Node2D
var escenaBala = load("res://bala_enemigo.tscn")
var velocidad_descenso: float = 120.0
var velocidad_horizontal: float = 180.0
var amplitud_zigzag: float = 200.0
var limite_y_superior: float = 0.0
var limite_y_inferior: float = 0.0
var centro_x: float = 0.0
var dir_x: int = 1
var dir_y: int = 1
var cadencia: float = 2
var disparando: bool = false
var timer_disparo: float = 0.0
var vida : float = Global.enemy_pequeno_vida
var muerto: bool = false

@onready var puntoDisparo = $Area2D/CollisionShape2D

func _ready() -> void:
	centro_x = position.x
	var alto = get_viewport().get_visible_rect().size.y
	limite_y_superior = position.y          # techo del zigzag (donde empieza)
	limite_y_inferior = alto * 0.55         # piso del zigzag

func _process(delta: float) -> void:
	# Movimiento horizontal (zigzag en X)
	position.x += dir_x * velocidad_horizontal * delta
	if position.x >= centro_x + amplitud_zigzag:
		position.x = centro_x + amplitud_zigzag
		dir_x = -1
	elif position.x <= centro_x - amplitud_zigzag:
		position.x = centro_x - amplitud_zigzag
		dir_x = 1

	# Movimiento vertical (zigzag en Y, infinito)
	position.y += dir_y * velocidad_descenso * delta
	if position.y >= limite_y_inferior:
		position.y = limite_y_inferior
		dir_y = -1
	elif position.y <= limite_y_superior:
		position.y = limite_y_superior
		dir_y = 1

	timer_disparo -= delta
	if timer_disparo <= 0 and !disparando:
		#print("Nueva ráfaga")
		timer_disparo = cadencia
		disparar()

func recibir_dano(cantidad: float) -> void:
	if muerto: return
	vida -= cantidad
	if vida <= 0:
		muerto = true
		AudioManager.play_muerte_enemigo()
		queue_free()
		
func disparar() -> void:
	disparando = true
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
		await get_tree().create_timer(0.25).timeout
	disparando = false
