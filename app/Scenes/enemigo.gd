extends Node2D

var velocidad: float = 200.0
var limite_x: float = 0.0
var avanzando: bool = true
var cadencia: float = 0.5
var timer_disparo: float = 0.0
var escenaBala = load("res://bala_enemigo.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limite_x = get_viewport().get_visible_rect().size.x * 0.45

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if avanzando:
			position.x += velocidad * delta
			if position.x >= limite_x:
				avanzando = false
	else:
		position.x -= velocidad*delta
		if position.x <= 10:
			avanzando = true
	if timer_disparo > 0:
		timer_disparo -= delta
	else:
		timer_disparo = cadencia
		disparar()
func disparar() -> void:
	var b = escenaBala.instantiate()
	b.global_position = global_position
	get_parent().add_child(b)
