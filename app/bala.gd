extends Node2D

var dir = Vector2(0,-1)
@export var velocidad: float = 800.0
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= velocidad*delta
	if position.y < -50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("recibir_dano") or area.get_parent().name == "Enemigo":
		Global.restar_vida_enemigo(100) 
		queue_free()
