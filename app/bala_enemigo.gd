extends Node2D

@export var velocidad: float = 600.0

func _process(delta: float) -> void:
	position.y += velocidad * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Jogador":
		Global.restar_vida_jugador(1) 
		queue_free()
