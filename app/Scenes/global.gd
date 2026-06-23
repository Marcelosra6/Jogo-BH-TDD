extends Node

var max_player_vida: int = 5
var player_vida: int = 5
var enemy_vida: float = 100000.0

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
	get_tree().paused = true #congela todo
