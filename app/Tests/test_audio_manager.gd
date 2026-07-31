@tool
extends GutTest

func pre_run():
	Global.reset_game()

func test_audio_manager_existe():
	assert_not_null(AudioManager, "AudioManager debe ser un autoload accesible")
	assert_true(AudioManager.has_method("play_bala"), "AudioManager debe tener play_bala")
	assert_true(AudioManager.has_method("play_bala_enemigo"), "AudioManager debe tener play_bala_enemigo")
	assert_true(AudioManager.has_method("play_bola_enemigo"), "AudioManager debe tener play_bola_enemigo")
	assert_true(AudioManager.has_method("play_muerte_enemigo"), "AudioManager debe tener play_muerte_enemigo")
	assert_true(AudioManager.has_method("play_muerte"), "AudioManager debe tener play_muerte")


func test_play_bala_reproduce():
	var antes = AudioManager.balaAudio.playing
	AudioManager.play_bala()
	assert_true(AudioManager.balaAudio.playing,
		"play_bala debe reproducir el sonido de bala")
	if antes:
		AudioManager.balaAudio.stop()

func test_play_bala_enemigo_reproduce():
	var antes = AudioManager.balaEnAud.playing
	AudioManager.play_bala_enemigo()
	assert_true(AudioManager.balaEnAud.playing,
		"play_bala_enemigo debe reproducir el sonido")
	if antes:
		AudioManager.balaEnAud.stop()

func test_play_bola_enemigo_reproduce():
	var antes = AudioManager.bolaEnAud.playing
	AudioManager.play_bola_enemigo()
	assert_true(AudioManager.bolaEnAud.playing,
		"play_bola_enemigo debe reproducir el sonido")
	if antes:
		AudioManager.bolaEnAud.stop()

func test_play_muerte_enemigo_reproduce():
	var antes = AudioManager.muerteEnAu.playing
	AudioManager.play_muerte_enemigo()
	assert_true(AudioManager.muerteEnAu.playing,
		"play_muerte_enemigo debe reproducir el sonido")
	if antes:
		AudioManager.muerteEnAu.stop()

func test_play_muerte_reproduce():
	var antes = AudioManager.muerte.playing
	AudioManager.play_muerte()
	assert_true(AudioManager.muerte.playing,
		"play_muerte debe reproducir el sonido")
	if antes:
		AudioManager.muerte.stop()

func test_play_stop_replay():
	AudioManager.play_bala()
	AudioManager.play_bala()
	assert_true(AudioManager.balaAudio.playing,
		"play_bala debe reiniciar si ya está sonando")
	AudioManager.balaAudio.stop()
