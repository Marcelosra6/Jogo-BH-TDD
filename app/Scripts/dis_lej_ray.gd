extends Node2D
var escenaLazer = load("res://Scenes/lazer.tscn")
var cooldown: float = 5.0
var timer_disparo: float = 0.0
var vida: float = Global.enemy_laser_vida   # ya no comparte con el boss
var muerto: bool = false
# para el rayo
@export var num_balas: int = 10
@export var cadencia: float = 0.05

@onready var puntoDisparo: Node2D = $"Area2D/inicio rayo"

func _ready() -> void:
	timer_disparo = cooldown

func _process(delta: float) -> void:
	if muerto:
		return
	timer_disparo -= delta
	if timer_disparo <= 0:
		timer_disparo = cooldown
		disparar_lazeres()

func disparar_lazeres() -> void:
	AudioManager.play_bala_enemigo2()
	for i in num_balas:
		if muerto:
			return
		var l = escenaLazer.instantiate()
		l.global_position = puntoDisparo.global_position
		get_parent().add_child(l)
		await get_tree().create_timer(cadencia).timeout

func recibir_dano(cantidad: float) -> void:
	if muerto:
		return
	vida -= cantidad
	if vida <= 0:
		muerto = true
		AudioManager.play_muerte_enemigo()
		queue_free()
