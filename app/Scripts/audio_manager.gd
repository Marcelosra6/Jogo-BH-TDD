extends Node2D

@onready var balaAudio: AudioStreamPlayer2D = $BalaAudio
@onready var balaEnAud: AudioStreamPlayer2D = $BalaEnemigoAudio
@onready var bolaEnAud: AudioStreamPlayer2D = $BolaEnemigoAudio
@onready var muerteEnAu: AudioStreamPlayer2D = $MuerteEnemigoAudio
@onready var muerte: AudioStreamPlayer2D = $Muerte

func _play(player: AudioStreamPlayer2D) -> void:
	if player.playing:
		player.stop()
	player.play()

func play_bala() -> void:
	_play(balaAudio)

func play_bala_enemigo() -> void:
	_play(balaEnAud)

func play_bola_enemigo() -> void:
	_play(bolaEnAud)

func play_muerte_enemigo() -> void:
	_play(muerteEnAu)

func play_muerte() -> void:
	_play(muerte)
