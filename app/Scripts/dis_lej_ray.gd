extends Node2D
var escenaLazer = load("res://Scenes/lazer.tscn")
var radio: float = 0.0
var vertices: Array = []
var cooldown: float = 5.0
var timer_disparo: float = 0.0
var vida: float = Global.enemy_laser_vida   # ← corregido, ya no comparte con el boss
var muerto: bool = false

func _ready() -> void:
	radio = get_viewport().get_visible_rect().size.x / 2.0
	crear_formacion()
	timer_disparo = cooldown

func crear_formacion() -> void:
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
	if muerto: return
	vida -= cantidad
	if vida <= 0:
		muerto = true
		AudioManager.play_muerte_enemigo()
		queue_free()
