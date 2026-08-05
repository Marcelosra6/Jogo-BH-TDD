extends Area2D
@export var duracion_activo: float = 1.5
@export var tiempo_aviso: float = 0.4
@onready var sprite: Sprite2D = $Sprite2D
@onready var colision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var alto_pantalla = get_viewport().get_visible_rect().size.y
	estirar_hacia_abajo(alto_pantalla)
	monitoring = false
	modulate.a = 0.3
	await get_tree().create_timer(tiempo_aviso).timeout
	activar()

func estirar_hacia_abajo(alto: float) -> void:
	if sprite.texture:
		sprite.scale.y = alto / sprite.texture.get_height()
		sprite.offset.y = sprite.texture.get_height() / 2.0
	if colision.shape is RectangleShape2D:
		colision.shape.size.y = alto
		colision.position.y = alto / 2.0

func activar() -> void:
	monitoring = true
	modulate.a = 1.0
	await get_tree().create_timer(duracion_activo).timeout
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Jogador":
		Global.restar_vida_jugador(1)
