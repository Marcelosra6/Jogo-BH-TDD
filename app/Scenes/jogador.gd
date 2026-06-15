extends Node2D

var escenaBala = load("res://bala.tscn")
var cadencia = 0.2
var timer_disparo = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	if timer_disparo > 0:
		timer_disparo -= delta
	if Input.is_action_pressed("click") and timer_disparo <= 0:
		timer_disparo = cadencia
		disparar()
func disparar() -> void:
	var b = escenaBala.instantiate()
	b.global_position = global_position
	get_parent().add_child(b)
