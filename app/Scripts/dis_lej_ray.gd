extends Node2D

var escenaLazer = load("res://Scenes/lazer.tscn")

var radio: float = 0.0
var vertices: Array = []
var cooldown: float = 5.0
var timer_disparo: float = 0.0
var vida = Global.enemy_vida

static func espawnear(padre: Node, posicion: Vector2) -> void:
	var escena = load("res://Scenes/dis_lej_ray.tscn")
	var e = escena.instantiate()
	e.global_position = posicion
	padre.add_child(e)

func _ready() -> void:
	radio = get_viewport().get_visible_rect().size.x / 2.0
	crear_pentagono_invertido()
	timer_disparo = cooldown

func crear_pentagono_invertido() -> void:
	var textura = preload("res://Imgs/enemigo pequeño rayo.png")
	for i in 5:
		var ang = deg_to_rad(90.0 + i * 72.0)
		var sprite = Sprite2D.new()
		sprite.texture = textura
		sprite.scale = Vector2(0.08782328, 0.086672954)
		sprite.position = Vector2(cos(ang), sin(ang)) * radio
		add_child(sprite)
		vertices.append(sprite)

func _process(delta: float) -> void:
	if vida <= 0:
		return
	timer_disparo -= delta
	if timer_disparo <= 0:
		timer_disparo = cooldown
		disparar_lazeres()

func disparar_lazeres() -> void:
	for v in vertices:
		var l = escenaLazer.instantiate()
		l.global_position = v.global_position
		get_parent().add_child(l)
	AudioManager.play_bala_enemigo2()

func recibir_dano(cantidad: float) -> void:
	Global.restar_vida_enemigo(cantidad)
