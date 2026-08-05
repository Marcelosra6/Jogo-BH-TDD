extends Area2D

@onready var Escena_piramide = load("res://Scenes/dis_lej_ray.tscn")
@onready var Escena_nave_en = load("res://Scenes/dis_pej_bal.tscn")
@onready var Escena_kamikaze = load("res://Scenes/kamikaze.tscn")

@export var boss_path: NodePath  # arrastra el nodo del boss REAL aquí desde el editor
var boss: Node = null
var puede_spawnear: bool = true

func _ready() -> void:
	if boss_path != NodePath():
		boss = get_node(boss_path)
	$cooldown.timeout.connect(_on_cooldown_timeout)

func _process(delta: float) -> void:
	if boss == null:
		return
	if boss.finInicial == true and boss.vida > 0 and puede_spawnear:
		var roll = randi_range(1, 100)
		if roll <= 40:
			spawn_kamikaze()
		elif roll <= 75: # 40 + 35
			spawn_nave()
		else: # 25 restante
			spawn_piramide()

func _on_cooldown_timeout() -> void:
	puede_spawnear = true

func spawn_nave() -> void:
	puede_spawnear = false
	$cooldown.start()
	var instancia = Escena_nave_en.instantiate()
	instancia.global_position = global_position
	get_tree().current_scene.add_child(instancia)

func spawn_piramide() -> void:
	puede_spawnear = false
	$cooldown.start()
	var instancia = Escena_piramide.instantiate()
	instancia.global_position = global_position
	get_tree().current_scene.add_child(instancia)

func spawn_kamikaze() -> void:
	puede_spawnear = false
	$cooldown.start()
	var instancia = Escena_kamikaze.instantiate()
	instancia.global_position = global_position
	get_tree().current_scene.add_child(instancia)
