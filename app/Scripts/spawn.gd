extends Area2D

@onready var Escena_piramide = load("res://Scenes/dis_lej_ray.tscn")
@onready var Escena_nave_en = load("res://Scenes/dis_pej_bal.tscn")
@onready var Escena_kamikaze = load("res://Scenes/kamikaze.tscn")

@export var boss_path: NodePath  # arrastra el nodo del boss REAL aquí desde el editor
@export var cooldown_piramides: float = 2.0
@export var cooldown_naves: float = 2.0
@export var naves_por_cooldown: int = 3

var boss: Node = null
var puede_spawnear: bool = true
var formacion_piramides_activa: bool = false
var piramides_vivas: int = 0
var naves_spawned: int = 0

const PIRAMIDES_POR_FORMACION: int = 5
const TIEMPO_DESCENSO: float = 0.8
const DELAY_ENTRE_PIRAMIDES: float = 0.25

func _ready() -> void:
	if boss_path != NodePath():
		boss = get_node(boss_path)
	$cooldown.timeout.connect(_on_cooldown_timeout)
	$cooldown_piramides.one_shot = true
	$cooldown_piramides.wait_time = cooldown_piramides
	$cooldown_naves.one_shot = true
	$cooldown_naves.wait_time = cooldown_naves

func _process(delta: float) -> void:
	if boss == null:
		return
	if boss.finInicial == true and boss.vida > 0 and puede_spawnear:
		var roll = randi_range(1, 100)
		if roll <= 40:
			spawn_kamikaze()
		elif roll <= 75: # 40 + 35
			if $cooldown_naves.is_stopped():
				spawn_nave()
		else: # 25 restante
			if not formacion_piramides_activa and $cooldown_piramides.is_stopped():
				spawn_piramide()

func _on_cooldown_timeout() -> void:
	puede_spawnear = true

func spawn_nave() -> void:
	puede_spawnear = false
	$cooldown.start()
	naves_spawned += 1
	if naves_spawned >= naves_por_cooldown:
		naves_spawned = 0
		$cooldown_naves.start()
	var instancia = Escena_nave_en.instantiate()
	instancia.global_position = global_position
	get_tree().current_scene.add_child(instancia)

func spawn_piramide() -> void:
	puede_spawnear = false
	$cooldown.start()
	formacion_semicircular_piramides()

func formacion_semicircular_piramides() -> void:
	if boss == null:
		return
	formacion_piramides_activa = true
	var centro = boss.global_position
	var ancho = get_viewport().get_visible_rect().size.x
	var radio = ancho * 0.35
	for i in PIRAMIDES_POR_FORMACION:
		# semicírculo frente al boss (abultado hacia el jugador)
		var t = float(i) / float(PIRAMIDES_POR_FORMACION - 1)
		var ang = lerp(-PI / 2.0, PI / 2.0, t)
		var pos_final = Vector2(
			centro.x + radio * sin(ang),
			centro.y + radio * cos(ang)
		)
		var piramide = Escena_piramide.instantiate()
		# parte desde el spawn y desciende solo variando su eje y
		piramide.global_position = Vector2(pos_final.x, global_position.y)
		get_tree().current_scene.add_child(piramide)
		piramide.tree_exited.connect(_on_piramide_eliminada)
		piramides_vivas += 1
		var tween = piramide.create_tween()
		tween.tween_property(piramide, "global_position", pos_final, TIEMPO_DESCENSO)
		await get_tree().create_timer(DELAY_ENTRE_PIRAMIDES).timeout

func _on_piramide_eliminada() -> void:
	if piramides_vivas <= 0:
		return
	piramides_vivas -= 1
	if piramides_vivas == 0 and formacion_piramides_activa:
		formacion_piramides_activa = false
		$cooldown_piramides.start()

func spawn_kamikaze() -> void:
	puede_spawnear = false
	$cooldown.start()
	var instancia = Escena_kamikaze.instantiate()
	instancia.global_position = global_position
	get_tree().current_scene.add_child(instancia)
