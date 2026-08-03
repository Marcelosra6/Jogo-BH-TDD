extends Node2D

var escenaBala = load("res://bala_enemigo.tscn")

var velocidad_descenso: float = 120.0
var velocidad_horizontal: float = 180.0
var amplitud_zigzag: float = 200.0
var limite_y: float = 0.0
var centro_x: float = 0.0
var dir_x: int = 1
var detenido: bool = false

var cadencia: float = 3
var timer_disparo: float = 0.0
var vida: int = 3

static func espawnear(padre: Node) -> void:
	var escena = load("res://Scenes/dis_pej_bal.tscn")
	var ctd = randi_range(3, 6)
	var ancho = padre.get_viewport().get_visible_rect().size.x
	for i in ctd:
		var e = escena.instantiate()
		e.position = Vector2(randf_range(60.0, ancho - 60.0), -60.0 - i * 30.0)
		padre.add_child(e)

func _ready() -> void:
	centro_x = position.x
	var alto = get_viewport().get_visible_rect().size.y
	limite_y = alto * 0.55

func _process(delta: float) -> void:
	if vida <= 0:
		return
	if not detenido:
		position.y += velocidad_descenso * delta
		position.x += dir_x * velocidad_horizontal * delta
		if position.x >= centro_x + amplitud_zigzag:
			position.x = centro_x + amplitud_zigzag
			dir_x = -1
		elif position.x <= centro_x - amplitud_zigzag:
			position.x = centro_x - amplitud_zigzag
			dir_x = 1
		if position.y >= limite_y:
			position.y = limite_y
			detenido = true
	timer_disparo -= delta
	if timer_disparo <= 0:
		timer_disparo = cadencia
		disparar()

func disparar() -> void:
	var b = escenaBala.instantiate()
	b.global_position = global_position
	b.direccion = Vector2.DOWN
	get_parent().add_child(b)
	AudioManager.play_bala_enemigo()

func recibir_dano(cantidad: float) -> void:
	vida -= int(cantidad)
	if vida <= 0:
		queue_free()
