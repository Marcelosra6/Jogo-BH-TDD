extends Area2D
@export var velocidad: float = 900.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var colision: CollisionShape2D = $CollisionShape2D

var _limite_y: float

func _ready() -> void:
	monitoring = true
	_limite_y = get_viewport().get_visible_rect().size.y + 100.0

func _process(delta: float) -> void:
	global_position.y += velocidad * delta
	if global_position.y > _limite_y:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Jogador":
		Global.restar_vida_jugador(1)
		queue_free()
