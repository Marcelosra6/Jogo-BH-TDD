# bala.gd
extends Node2D
var dir = Vector2(0,-1)
@export var vel: float = 800.0

func _process(delta):
	position.y -= vel * delta
	if position.y < -50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var objetivo = area.get_parent()
	if objetivo.has_method("recibir_dano"):
		objetivo.recibir_dano(200)
		queue_free()
