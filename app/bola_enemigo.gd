extends Node2D

@export var velocidad: float = 500.0
var direccion: Vector2 = Vector2.DOWN

func _process(delta: float) -> void:
	position += direccion * velocidad * delta
	var vp = get_viewport_rect().size
	if position.y > vp.y + 50 or position.y < -50 or position.x > vp.x + 50 or position.x < -50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Jogador":
		Global.restar_vida_jugador(1) 
		queue_free()
