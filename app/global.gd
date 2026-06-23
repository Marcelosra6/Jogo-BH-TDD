extends Node

var max_player_vida: int = 5
var player_vida: int = 5
var enemy_vida: float = 10000.0
var player_velocidad: float = 400.0
var juego_terminado: bool = false

func _ready() -> void:
	reset_game()

func reset_game():
	player_vida = max_player_vida
	enemy_vida = 10000.0
	juego_terminado = false
	get_tree().paused = false

func restar_vida_jugador(cantidad: int):
	if juego_terminado: return
	player_vida -= cantidad
	print("Vida Jugador: ", player_vida)
	if player_vida <= 0:
		congelar_pantalla("GIT GUD NIGGA")

func restar_vida_enemigo(cantidad: float):
	if juego_terminado: return
	enemy_vida -= cantidad
	print("Vida Enemigo: ", enemy_vida)
	if enemy_vida <= 0:
		congelar_pantalla("GANASTE OWO")

func congelar_pantalla(mensaje: String):
	print(mensaje)
	juego_terminado = true
	get_tree().paused = true
	if enemy_vida <= 0:
		AudioManager.play_muerte_enemigo()
	else:
		AudioManager.play_muerte()
	var timer = get_tree().create_timer(2.0, false, true)
	await timer.timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/inicio.tscn")
