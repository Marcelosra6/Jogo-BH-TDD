extends Node

var max_player_vida: int = 5
var player_vida: int = 5
var enemy_vida: float = 100000.0
var enemy_kamikaze_vida: float = 600.0 #kamikaze
var enemy_pequeno_vida: float = 600.0 #disparo balas 
var enemy_laser_vida: float = 1000.0 #disparo balas 
var juego_terminado: bool = false

func _ready() -> void:
	reset_game()

func reset_game():
	player_vida = max_player_vida
	enemy_vida = 100000.0
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
		
#ENEMIGOS PEQUEÑOS
func restar_vida_enemigo_pequeno(cantidad: float):
	if juego_terminado: return
	enemy_pequeno_vida -= cantidad
	print("Vida Enemigo pequeño: ", enemy_pequeno_vida)
	if enemy_pequeno_vida <= 0:
		print()
func restar_vida_enemigo_laser(cantidad: float):
	if juego_terminado: return
	enemy_laser_vida -= cantidad
	print("Vida Enemigo laser: ", enemy_laser_vida)
	if enemy_laser_vida <= 0:
		print()
func restar_vida_enemigo_kamikaze(cantidad: float):
	if juego_terminado: return
	enemy_kamikaze_vida -= cantidad
	print("Vida Kamikaze: ", enemy_kamikaze_vida)
	if enemy_kamikaze_vida <= 0:
		print()		
func congelar_pantalla(mensaje: String):
	print(mensaje)
	juego_terminado = true
	get_tree().paused = true #congela todo
