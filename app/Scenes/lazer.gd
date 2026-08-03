extends Area2D

var tiempo_vida: float = 2.0

func _ready() -> void:
	if get_node_or_null("Timer") != null:
		return
	var t = Timer.new()
	t.name = "Timer"
	t.wait_time = tiempo_vida
	t.one_shot = true
	t.timeout.connect(queue_free)
	add_child(t)
	t.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Jogador":
		Global.restar_vida_jugador(1)
